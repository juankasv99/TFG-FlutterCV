import json
from urllib.request import urlopen

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
'libélula damisela',]

translated_list = []

fishes = ['crucian_carp', 'goldfish', 'bitterling', 'pale_chub', 'dace', 'carp', 'koi', 'pop-eyed_goldfish', 'killifish', 'crawfish', 'soft-shelled_turtle', 'tadpole', 'frog', 'freshwater_goby', 'loach', 'catfish', 'giant_snakehead', 'bluegill', 'yellow_perch', 'black_bass', 'pike', 'pond_smelt', 'sweetfish', 'cherry_salmon', 'char', 'stringfish', 'salmon', 'king_salmon', 'mitten_crab', 'guppy', 'nibble_fish', 'angelfish', 'neon_tetra', 'piranha', 'arowana', 'dorado', 'gar', 'arapaima', 'saddled_bichir', 'sea_butterfly', 'sea_horse', 'clownfish', 'surgeonfish', 'butterfly_fish', 'napoleonfish', 'zebra_turkeyfish', 'blowfish', 'puffer_fish', 'horse_mackerel', 'barred_knifejaw', 'sea_bass', 'red_snapper', 'dab', 'olive_flounder', 'squid', 'moray_eel', 'ribbon_eel', 'football_fish', 'tuna', 'blue_marlin', 'giant_trevally', 'ray', 'ocean_sunfish', 'hammerhead_shark', 'great_white_shark', 'saw_shark', 'whale_shark', 'oarfish', 'coelacanth', 'sturgeon', 'tilapia', 'betta', 'snapping_turtle', 'golden_trout', 'rainbowfish', 'anchovy', 'mahi-mahi', 'suckerfish', 'barreleye', 'ranchu_goldfish'];

fish1 = [
'anchovy',
'angelfish',
'arapaima',
'arowana',
'barred knifejaw',
'barreleye',
'betta',
'bitterling',
'black bass',
'blowfish',
'blue marlin',
'bluegill',
'butterfly fish',
'carp',
'catfish',
'char',
'cherry salmon',
'clownfish',
'coelacanth',
'crawfish',
'crucian carp',
'dab',
'dace',
'dorado',
'football fish',
'freshwater goby',
'frog',
'gar',
'giant snakehead',
'giant trevally',
'golden trout',
'goldfish',
'great white shark',
'guppy',
'hammerhead shark',
'horse mackerel',
'killifish',
'king salmon',
'koi',
'loach',
'mahi-mahi',
'mitten crab',
'moray eel',
'napoleonfish',
'neon tetra',
'nibble fish',
'oarfish',
'ocean sunfish',
'olive flounder',
'pale chub',
'pike',
'piranha',
'pond smelt',
'pop-eyed goldfish',
'puffer fish',
'rainbowfish',
'ranchu goldfish',
'ray',
'red snapper',
'ribbon eel',
'saddled bichir',
'salmon',
'saw shark',
'sea bass',
'sea butterfly',
'sea horse',
'snapping turtle',
'soft-shelled turtle',
'squid',
'stringfish',
'sturgeon',
'suckerfish',
'surgeonfish',
'sweetfish',
'tadpole',
'tilapia',
'tuna',
'whale shark',
'yellow perch',
'zebra turkeyfish',
]

fish2 = [
'Antyobi',
'Angelfish',
'Piraruku',
'Arowana',
'Ishidai',
'Demenigisu',
'Beta',
'Tanago',
'Blackbass',
'Fugu',
'Kajiki',
'Blueguill',
'Chouchouuo',
'Koi',
'Namazu',
'Ooiwana',
'Yamame',
'Kumanomi',
'Sirakansu',
'Zarigani',
'Funa',
'Karei',
'Ugui',
'Dolado',
'Chouchinankou',
'Donko',
'Kaeru',
'Ga',
'Raigyo',
'Rouninaji',
'GoldenTorauto',
'Kingyo',
'Same',
'Guppi',
'Shumokuzame',
'Aji',
'Medaka',
'Kingsalmon',
'Nishikigoi',
'Dojou',
'Shiira',
'Syanhaigani',
'Utsubo',
'Naporeonfish',
'Neontetora',
'Dokutaafish',
'Ryuuguunotukai',
'Manbou',
'Hirame',
'Oikawa',
'Paiku',
'Pirania',
'Wakasagi',
'Demekin',
'Harisenbon',
'Rainbowfish',
'Ranchu',
'Ei',
'Tai',
'Hanahigeutubo',
'Endorikerii',
'Sake',
'Nokogirizame',
'Suzuki',
'Kurione',
'Tatsunootoshigo',
'Kamitsukigame',
'Suppon',
'Ika',
'Itou',
'Tyouzame',
'Kobanzame',
'Nanyouhagi',
'Ayu',
'Otamajakusi',
'Thirapia',
'Maguro',
'Jinbeezame',
'Yellowparch',
'Minokasago',
]

insects = ['brown_cicada', 'tiger_butterfly', 'rajah_brookes_birdwing', 'red_dragonfly', 'queen_alexandras_birdwing', 'pondskater', 'ant', 'pill_bug', 'wharf_roach', 'moth', 'diving_beetle', 'darner_dragonfly', 'goliath_beetle', 'fly', 'orchid_mantis', 'tiger_beetle', 'horned_hercules', 'evening_cicada', 'cyclommatus_stag', 'firefly', 'dung_beetle', 'rice_grasshopper', 'mosquito', 'mantis', 'stinkbug', 'citrus_long-horned_beetle', 'peacock_butterfly', 'snail', 'horned_dynastid', 'grasshopper', 'earth-boring_dung_beetle', 'horned_atlas', 'walking_leaf', 'cricket', 'giant_cicada', 'spider', 'agrias_butterfly', 'robust_cicada', 'bagworm', 'honeybee', 'miyama_stag', 'yellow_butterfly', 'common_butterfly', 'emperor_butterfly', 'centipede', 'walking_stick', 'rainbow_stag', 'saw_stag', 'flea', 'mole_cricket', 'banded_dragonfly', 'monarch_butterfly', 'giant_stag', 'golden_stag', 'scarab_beetle', 'scorpion', 'cicada_shell', 'bell_cricket', 'wasp', 'long_locust', 'jewel_beetle', 'tarantula', 'ladybug', 'migratory_locust', 'walker_cicada', 'violin_beetle', 'hermit_crab', 'atlas_moth', 'horned_elephant', 'common_bluebottle', 'paper_kite_butterfly', 'great_purple_emperor', 'drone_beetle', 'giraffe_stag', 'man-faced_stink_bug', 'madagascan_sunset_moth', 'blue_weevil_beetle', 'rosalia_batesi_beetle', 'giant_water_bug', 'damselfly']

insect1 = [
'agrias butterfly',
'ant',
'atlas moth',
'bagworm',
'banded dragonfly',
'bell cricket',
'blue weevil beetle',
'brown cicada',
'centipede',
'cicada shell',
'citrus long-horned beetle',
'common bluebottle',
'common butterfly',
'cricket',
'cyclommatus stag',
'damselfly',
'darner dragonfly',
'diving beetle',
'drone beetle',
'dung beetle',
'earth-boring dung beetle',
'emperor butterfly',
'evening cicada',
'firefly',
'flea',
'fly',
'giant cicada',
'giant stag',
'giant water bug',
'giraffe stag',
'golden stag',
'goliath beetle',
'grasshopper',
'great purple emperor',
'hermit crab',
'honeybee',
'horned atlas',
'horned dynastid',
'horned elephant',
'horned hercules',
'jewel beetle',
'ladybug',
'long locust',
'madagascan sunset moth',
'man-faced stink bug',
'mantis',
'migratory locust',
'miyama stag',
'mole cricket',
'monarch butterfly',
'mosquito',
'moth',
'orchid mantis',
'paper kite butterfly',
'peacock butterfly',
'pill bug',
'pondskater',
'queen alexandras birdwing',
'rainbow stag',
'rajah brookes birdwing',
'red dragonfly',
'rice grasshopper',
'robust cicada',
'rosalia batesi beetle',
'saw stag',
'scarab beetle',
'scorpion',
'snail',
'spider',
'stinkbug',
'tarantula',
'tiger beetle',
'tiger butterfly',
'violin beetle',
'walker cicada',
'walking leaf',
'walking stick',
'wasp',
'wharf roach',
'yellow butterfly',
]

insect2 = [
'Miirotateha',
'Ari',
'Yonagunisan',
'Minomushi',
'Oniyanma',
'Suzumushi',
'Housekizoumushi',
'Aburazemi',
'Mukade',
'Seminonukegara',
'Gomadarakamikiri',
'Aosujiageha',
'Monshirocho',
'Kohrogi',
'Hosoakakuwagata',
'Itotonbo',
'Ginyanma',
'Gengorou',
'Kanabun',
'Funkorogashi',
'Ohsenchikogane',
'Morufuocho',
'Higurashi',
'Hotaru',
'Nomi',
'Hae',
'Kumazemi',
'Ohkuwagata',
'Tagame',
'Girafanokogirikuwagata',
'Ougononikuwagata',
'Goraiasuohtsunohanamuguri',
'Kirigirisu',
'Ohmurasaki',
'Yadokari',
'Mitsubachi',
'Kohkasasuohkabuto',
'Kabutomushi',
'Zoukabuto',
'Herakuresuohkabuto',
'Tamamushi',
'Tentoumushi',
'Shoryobatta',
'Nishikiohtsubamega',
'Jinmenkamemushi',
'Kamakiri',
'Tonosamabatta',
'Miyamakuwagata',
'Okera',
'Ohkabamadara',
'Ka',
'Ga',
'Hanakamakiri',
'Ohgomamadara',
'Karasuageha',
'Dangomushi',
'Amenbo',
'Arekisandoratoribaneageha',
'Nijiirokuwagata',
'Akaeritoribaneageha',
'Akiakane',
'Inago',
'Minminzemi',
'Ruriboshikamikiri',
'Nokogirikuwagata',
'Purachinakogane',
'Sasori',
'Katatsumuri',
'Kumo',
'Kamemushi',
'Taranchura',
'Hanmyou',
'Agehacho',
'Baiorinmushi',
'Tsukutsukuhousi',
'Konohamushi',
'Nanafushi',
'Hachi',
'Funamushi',
'Monkicho',
]

sea = ['seaweed', 'sea_grapes', 'sea_cucumber', 'sea_pig', 'sea_star', 'sea_urchin', 'slate_pencil_urchin', 'sea_anemone', 'moon_jellyfish', 'sea_slug', 'pearl_oyster', 'mussel', 'oyster', 'scallop', 'whelk', 'turban_shell', 'abalone', 'gigas_giant_clam', 'chambered_nautilus', 'octopus', 'umbrella_octopus', 'vampire_squid', 'firefly_squid', 'gazami_crab', 'dungeness_crab', 'snow_crab', 'red_king_crab', 'acorn_barnacle', 'spider_crab', 'tiger_prawn', 'sweet_shrimp', 'mantis_shrimp', 'spiny_lobster', 'lobster', 'giant_isopod', 'horseshoe_crab', 'sea_pineapple', 'spotted_garden_eel', 'flatworm', 'venus_flower_basket']

sea1 = [
'abalone',
'acorn barnacle',
'chambered nautilus',
'dungeness crab',
'firefly squid',
'flatworm',
'gazami crab',
'giant isopod',
'gigas giant clam',
'horseshoe crab',
'lobster',
'mantis shrimp',
'moon jellyfish',
'mussel',
'octopus',
'oyster',
'pearl oyster',
'red king crab',
'scallop',
'sea anemone',
'sea cucumber',
'sea grapes',
'sea pig',
'sea pineapple',
'sea slug',
'sea star',
'sea urchin',
'seaweed',
'slate pencil urchin',
'snow crab',
'spider crab',
'spiny lobster',
'spotted garden eel',
'sweet shrimp',
'tiger prawn',
'turban shell',
'umbrella octopus',
'vampire squid',
'venus flower basket',
'whelk',
]

sea2 = [
'Awabi',
'Fujitsubo',
'Oumugai',
'DungenessCrab',
'Hotaruika',
'Hiramushi',
'Gazami',
'Daiougusokumushi',
'Shakogai',
'Kabutogani',
'Fish54',
'Shako',
'Mizukurage',
'Muhrugai',
'Tako',
'Kaki',
'Akoyagai',
'Tarabagani',
'Hotate',
'Isogintyaku',
'Namako',
'Umibudou',
'Senjunamako',
'Hoya',
'Umiushi',
'Hitode',
'Uni',
'Wakame',
'Paipuuni',
'Zuwaigani',
'Takaashigani',
'Iseebi',
'Chinanago',
'Amaebi',
'Kurumaebi',
'Sazae',
'Mendako',
'Koumoridako',
'Kairoudouketsu',
'Baigai',
]

fish_dict = {}
for x in range(len(sea1)):
    fish_dict[sea1[x]]=sea2[x]

fish_names = []
for fish in sea:
    fish_names.append(fish_dict[fish.replace("_"," ")])

print(fish_names)



url = "http://acnhapi.com/v1/sea/"
response = urlopen(url)
data = json.loads(response.read())

print([value["file-name"] for key,value in data.items()])

for fish in insect_list:
    for key, value in data.items():
        if value["name"]["name-EUes"] == fish:
            translated_list.append(value["file-name"])

print(translated_list)


