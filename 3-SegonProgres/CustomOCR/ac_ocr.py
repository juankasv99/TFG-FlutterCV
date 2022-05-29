import os
import tensorflow as tf
import numpy as np
import cv2
import torch
import easyocr
from difflib import SequenceMatcher
from matplotlib import pyplot as plt
from object_detection.utils import label_map_util
from object_detection.utils import config_util
from object_detection.utils import visualization_utils as viz_utils
from object_detection.builders import model_builder
from flask import Flask, jsonify, request
from PIL import Image
from PIL.ExifTags import TAGS

os.environ['TF_CPP_MIN_LOG_LEVEL'] = '2'    # Suppress TensorFlow logging
detection_threshold = 0.7

MODEL_NAME = "my_model"
DATA_DIR = os.path.join(os.getcwd(), r'TensorFlow\workspace\training')
MODELS_DIR = os.path.join(DATA_DIR, 'exported-models')
PATH_TO_CFG = os.path.join(MODELS_DIR, os.path.join(MODEL_NAME, 'pipeline.config'))
PATH_TO_CKPT = os.path.join(MODELS_DIR, os.path.join(MODEL_NAME, 'checkpoint/'))
LABEL_FILENAME = 'label_map.pbtxt'
PATH_TO_LABELS = os.path.join(MODELS_DIR, os.path.join(MODEL_NAME, LABEL_FILENAME))

eng_fish_list = [
    'Funa', 'Kingyo', 'Tanago', 'Oikawa', 'Ugui', 'Koi', 'Nishikigoi', 'Demekin', 'Medaka', 'Zarigani', 'Suppon', 'Otamajakusi', 'Kaeru', 'Donko', 'Dojou', 'Namazu', 'Raigyo', 'Blueguill', 'Yellowparch', 'Blackbass', 'Paiku', 'Wakasagi', 'Ayu', 'Yamame', 'Ooiwana', 'Itou', 'Sake', 'Kingsalmon', 'Syanhaigani', 'Guppi', 'Dokutaafish', 'Angelfish', 'Neontetora', 'Pirania', 'Arowana', 'Dolado', 'Ga', 'Piraruku', 'Endorikerii', 'Kurione', 'Tatsunootoshigo', 'Kumanomi', 'Nanyouhagi', 'Chouchouuo', 'Naporeonfish', 'Minokasago', 'Fugu', 'Harisenbon', 'Aji', 'Ishidai', 'Suzuki', 'Tai', 'Karei', 'Hirame', 'Ika', 'Utsubo', 'Hanahigeutubo', 'Chouchinankou', 'Maguro', 'Kajiki', 'Rouninaji', 'Ei', 'Manbou', 'Shumokuzame', 'Same', 'Nokogirizame', 'Jinbeezame', 'Ryuuguunotukai', 'Sirakansu', 'Tyouzame', 'Thirapia', 'Beta', 'Kamitsukigame', 'GoldenTorauto', 'Rainbowfish', 'Antyobi', 'Shiira', 'Kobanzame', 'Demenigisu', 'Ranchu'
]

fish_list = ['carpín',
'pez dorado',
'amarguillo',
'cacho',
'leucisco',
'carpa',
'koi',
'pez telescopio',
'killi',
'cangrejo de río',
'tortuga caparazón blando',
'renacuajo',
'rana',
'gobio de río',
'locha',
'siluro',
'pez cabeza de serpiente',
'pez sol',
'perca amarilla',
'perca',
'lucio',
'eperlano',
'ayu',
'salmón japonés',
'trucha',
'taimén',
'salmón',
'salmón real',
'cangrejo de Shanghái',
'gupi',
'pez doctor',
'pez ángel',
'tetra neón',
'piraña',
'arowana',
'dorado',
'pez caimán',
'pirarucú',
'bichir ensillado',
'mariposa marina',
'caballito de mar',
'pez payaso',
'pez cirujano',
'pez mariposa',
'pez napoleón',
'pez león',
'pez globo',
'pez erizo',
'jurel',
'dorada japonesa',
'lubina',
'pargo rojo',
'gallo',
'rodaballo',
'calamar',
'morena',
'anguila de listón azul',
'pez balón',
'atún',
'pez espada',
'jurel gigante',
'raya',
'pez luna',
'pez martillo',
'tiburón',
'pez sierra',
'tiburón ballena',
'pez remo',
'celacanto',
'esturión',
'tilapia',
'betta',
'tortuga mordedora',
'trucha dorada',
'pez arcoíris',
'boquerón',
'lampuga',
'rémora',
'pez cabeza transparente',
'ranchú']


eng_insect_list = ['Aburazemi', 'Agehacho', 'Akaeritoribaneageha', 'Akiakane', 'Arekisandoratoribaneageha', 'Amenbo', 'Ari', 'Dangomushi', 'Funamushi', 'Ga', 'Gengorou', 'Ginyanma', 'Goraiasuohtsunohanamuguri', 'Hae', 'Hanakamakiri', 'Hanmyou', 'Herakuresuohkabuto', 'Higurashi', 'Hosoakakuwagata', 'Hotaru', 'Funkorogashi', 'Inago', 'Ka', 'Kamakiri', 'Kamemushi', 'Gomadarakamikiri', 'Karasuageha', 'Katatsumuri', 'Kabutomushi', 'Kirigirisu', 'Ohsenchikogane', 'Kohkasasuohkabuto', 'Konohamushi', 'Kohrogi', 'Kumazemi', 'Kumo', 'Miirotateha', 'Minminzemi', 'Minomushi', 'Mitsubachi', 'Miyamakuwagata', 'Monkicho', 'Monshirocho', 'Morufuocho', 'Mukade', 'Nanafushi', 'Nijiirokuwagata', 'Nokogirikuwagata', 'Nomi', 'Okera', 'Oniyanma', 'Ohkabamadara', 'Ohkuwagata', 'Ougononikuwagata', 'Purachinakogane', 'Sasori', 'Seminonukegara', 'Suzumushi', 'Hachi', 'Shoryobatta', 'Tamamushi', 'Taranchura', 'Tentoumushi', 'Tonosamabatta', 'Tsukutsukuhousi', 'Baiorinmushi', 'Yadokari', 'Yonagunisan', 'Zoukabuto', 'Aosujiageha', 'Ohgomamadara', 'Ohmurasaki', 'Kanabun', 'Girafanokogirikuwagata', 'Jinmenkamemushi', 'Nishikiohtsubamega', 'Housekizoumushi', 'Ruriboshikamikiri', 'Tagame', 'Itotonbo']

insect_list = ['cigarra marrón',
'mariposa tigre',
'mariposa alas de Brooke',
'libélula roja',
'mariposa alas de pájaro',
'zapatero',
'hormiga',
'cochinilla',
'cochinilla de arena',
'polilla',
'escarabajo nadador',
'libélula caballito del diablo',
'goliat',
'mosca',
'mantis orquídea',
'escarabajo tigre',
'escarabajo astado hércules',
'cigarrilla',
'esc. ciervo cyclommatus',
'luciérnaga',
'escarabajo pelotero',
'langosta',
'mosquito',
'mantis religiosa',
'chinche',
'longicornio asiático',
'mariposa bianor',
'caracol',
'escarabajo astado japonés',
'saltamontes',
'escarabajo geotrúpido',
'escarabajo astado atlas',
'insecto hoja',
'grillo común',
'cigarra gigante',
'araña',
'mariposa narciso',
'cigarra oriental',
'oruga de bolsón',
'abeja melífera',
'escarabajo ciervo Miyama',
'mariposa colias',
'mariposa común',
'mariposa celeste',
'ciempiés',
'insecto palo',
'escarabajo ciervo arcoíris',
'escarabajo ciervo sierra',
'pulga',
'grillo cebollero',
'libélula tigre',
'mariposa monarca',
'escarabajo ciervo gigante',
'escarabajo ciervo tornasol',
'escarabajo oro',
'escorpión',
'muda de cigarra',
'grillo campana',
'avispa',
'langosta alargada',
'escarabajo joya',
'tarántula',
'mariquita',
'langosta migratoria',
'cigarra común',
'escarabajo violín',
'cangrejo ermitaño',
'polilla atlas',
'escarabajo astado elefante',
'mariposa triángulo azul',
'mariposa cometa de papel',
'marip. emperador japonés',
'escarabajo verde japonés',
'escarabajo ciervo jirafa',
'chinche con rostro humano',
'polilla crepuscular',
'gorgojo azul',
'escarabajo rosalia batesi',
'chinche acuática gigante',
'libélula damisela']


eng_sea_list = ['Wakame', 'Umibudou', 'Namako', 'Senjunamako', 'Hitode', 'Uni', 'Paipuuni', 'Isogintyaku', 'Mizukurage', 'Umiushi', 'Akoyagai', 'Muhrugai', 'Kaki', 'Hotate', 'Baigai', 'Sazae', 'Awabi', 'Shakogai', 'Oumugai', 'Tako', 'Mendako', 'Koumoridako', 'Hotaruika', 'Gazami', 'DungenessCrab', 'Zuwaigani', 'Tarabagani', 'Fujitsubo', 'Takaashigani', 'Kurumaebi', 'Amaebi', 'Shako', 'Iseebi', 'Fish54', 'Daiougusokumushi', 'Kabutogani', 'Hoya', 'Chinanago', 'Hiramushi', 'Kairoudouketsu']
sea_list = ['alga wakame', 'uva de mar', 'pepino de mar', 'cerdo de mar', 'estrella de mar', 'erizo de mar', 'erizo lápiz de pizarra', 'anémona', 'medusa luna', 'babosa de mar', 'ostra perlera', 'mejillón', 'ostra', 'vieira', 'buccino', 'caracola espinosa', 'abulón', 'taclobo gigante', 'nautilo', 'pulpo', 'pulpo paraguas', 'calamar vampiro', 'calamar luciérnaga', 'cangrejo gazami', 'buey del Pacífico', 'cangrejo de nieve', 'cangrejo boreal', 'bellota de mar', 'cangrejo gigante japonés', 'langostino tigre', 'camarón boreal', 'langosta mantis', 'langosta espinosa', 'bogavante', 'isópodo gigante', 'cangrejo herradura', 'piña de mar', 'anguila jardinera', 'gusano políclado', 'canasta de flores de Venus']


# Prevent GPU complete consumption
gpus = tf.config.list_physical_devices('GPU')
if gpus:
    try:
        tf.config.experimental.set_virtual_device_configuration(
            gpus[0], [tf.config.experimental.VirtualDeviceConfiguration(memory_limit=5120)]
        )
    except RuntimeError as e:
        print(e)

tf.get_logger().setLevel('ERROR')

# Load pipeline config and build a detection model
configs = config_util.get_configs_from_pipeline_file(PATH_TO_CFG)
model_config = configs['model']
detection_model = model_builder.build(model_config=model_config, is_training=False)

# Restore checkpoint
ckpt = tf.compat.v2.train.Checkpoint(model=detection_model)
ckpt.restore(os.path.join(PATH_TO_CKPT, 'ckpt-0')).expect_partial()

@tf.function
def detect_fn(image):
    """Detect objects in image."""

    image, shapes = detection_model.preprocess(image)
    prediction_dict = detection_model.predict(image, shapes)
    detections = detection_model.postprocess(prediction_dict, shapes)

    return detections, prediction_dict, tf.reshape(shapes, [-1])

category_index = label_map_util.create_category_index_from_labelmap(PATH_TO_LABELS,
                                                                    use_display_name=True)

def detect_box(input_image):
    #img = cv2.imread(input_image)

    image_np = np.array(input_image)
    input_tensor = tf.convert_to_tensor(np.expand_dims(image_np, 0), dtype=tf.float32)
    detections = detect_fn(input_tensor)
    num_detections = int(detections[0].pop('num_detections'))
    detections = {key: value[0, :num_detections].numpy()
                for key, value in detections[0].items()}
    detections['num_detections'] = num_detections

    # detection_classes should be ints.
    detections['detection_classes'] = detections['detection_classes'].astype(np.int64)

    label_id_offset = 1
    image_np_with_detections = image_np.copy()

    # viz_utils.visualize_boxes_and_labels_on_image_array(
    #             image_np_with_detections,
    #             detections['detection_boxes'],
    #             detections['detection_classes']+label_id_offset,
    #             detections['detection_scores'],
    #             category_index,
    #             use_normalized_coordinates=True,
    #             max_boxes_to_draw=5,
    #             min_score_thresh=.8,
    #             agnostic_mode=False)

    #plt.imshow(cv2.cvtColor(image_np_with_detections, cv2.COLOR_BGR2RGB))
    #plt.show()
    return detections, image_np_with_detections

def run_ocr(detections, image):
    scores = list(filter(lambda x: x> detection_threshold, detections['detection_scores']))
    boxes = detections['detection_boxes'][:len(scores)]
    classes = detections['detection_classes'][:len(scores)]

    width = image.shape[1]
    height = image.shape[0]

    #ROI filtering + OCR
    for idx, box in enumerate(boxes):
        # Convert image to grayscale
        image = np.tile(
            np.mean(image, 2, keepdims=True), (1, 1, 3)).astype(np.uint8)

        roi = box*[height, width, height, width]
        region = image[int(roi[0]):int(roi[2]), int(roi[1]):int(roi[3])]

        reader = easyocr.Reader(['es', 'en'])
        ocr_result = reader.readtext(region, slope_ths=3, width_ths=5)

        for ocr_text in ocr_result:
            print(ocr_text)
            if ocr_text[2]>0.65:
                cv2.rectangle(region, [round(num) for num in ocr_text[0][0]], [round(num) for num in ocr_text[0][2]], (255, 0, 0), 5)

        #plt.imshow(cv2.cvtColor(region, cv2.COLOR_BGR2RGB))
        #plt.show()

        texto = ' '.join([ocr_text[1] for ocr_text in ocr_result if ocr_text[2]>0.6])
        print(texto)
        insect_predictions = [insect for insect in insect_list if insect in texto]
        fish_predictions = [insect for insect in fish_list if insect in texto]
        sea_predictions = [sea for sea in sea_list if sea in texto]

        if insect_predictions:
            if len(insect_predictions) > 1:
                result =  max(insect_predictions, key=len)
            else:
                result = insect_predictions[0]
            index = insect_list.index(result)
            result = eng_insect_list[index]
                
        if fish_predictions:
            if len(fish_predictions) > 1:
                result = max(fish_predictions, key=len)
            else:
                result = fish_predictions[0]
            index = fish_list.index(result)
            result = eng_fish_list[index]
        
        if sea_predictions:
            if len(sea_predictions) > 1:
                result = max(sea_predictions, key=len)
            else:
                result = sea_predictions[0]
            index = sea_list.index(result)
            result = eng_sea_list[index]
            
        
        return result

app = Flask(__name__)

@app.route('/predictocr', methods=['POST'])
def infer_ocr():
    #catch the image file from a POST request
    print("Start Process")
    if 'file' not in request.files:
        return "Please try again. The image doesn't exist"

    file = request.files.get('file')
    if not file:
        return
    
    #read the image
    img_bytes = request.files['file']
    img = Image.open(img_bytes)

    exif_data = img._getexif()
    if(exif_data):

        for key,value in exif_data.items():
            if TAGS.get(key) == 'Orientation':
                orientation = value

        if orientation == 6:
            img = img.rotate(270)
        if orientation == 3:
            img = img.rotate(180)
        if orientation == 8:
            im = im.rotate(90)

    img.show()
    #return on a json format
    print("Start Box Detection")
    detections, processed_image = detect_box(img)
    print("Start OCR")
    ocr_result = run_ocr(detections, processed_image)
    print("Returns")
    return jsonify(prediction = ocr_result)

@app.route('/', methods=['GET'])
def index():
    return 'Animal Crossing Animals OCR'


if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')
