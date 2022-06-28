# FlutterCV

<div style="text-align:center; height: 300px;"><img src="6- Dossier/portada dossier.png" /></div>

# Taula de continguts
  * [Sobre aquest repositori](#sobre-aquest-repositori)
  * [Què és FlutterCV?](#què-és-fluttercv)
  * [Organització de directoris](#organització-de-directoris)
  * [Vídeo Demostració](#vídeo-demostració)
  * [Instal·lació i ús](#installació-i-ús)
    * [Desenvolupadors](#desenvolupadors)
      * [Instal·lació de YOLOv5](#installació-de-yolov5)
      * [Instal·lació de Flutter](#installació-de-flutter)
    * [Usuaris App](#usuaris-app)
  * [Arquitectura models d'IA](#arquitectura-models-dia)
    * [YOLOv5 per Object Detection (Cloud)](#yolov5-per-object-detection-cloud)
      * [Detecció d'obres d'art](#detecció-dobres-dart)
      * [Detecció de bombolles de text](#detecció-de-bombolles-de-text)
    * [SSDMobileNetV2 per Image Classification (Local)](#ssdmobilenetv2-per-image-classification-local)
    * [OCR Cloud - EasyOCR](#ocr-cloud---easyocr)
    * [OCR Local - ML-Kit](#ocr-local---ml-kit)
  * [Ús de l'aplicació](#ús-de-laplicació)
  * [Captures de l'aplicació](#captures-de-laplicació)

# Sobre aquest repositori

Aquest repositori conté tot el material tant de codi com d'assets utilitzats en el desenvolupament del projecte FlutterCV, un treball de Fi de Grau que contempla la creació de models d'IA amb l'objectiu de fer un desplegament en dispositius mòbils, sense la gran capacitat de còmput que poden tenir els ordinadors convencionals.
Tot el material ha estat desenvolupat per l'estudiant d'Enginyeria Informàtica en menció de Computació Juan Carlos Soriano Valle

# Què és FlutterCV?

FlutterCV és un projecte que aspira a endinsar-se en dos mons que no s'han tractat mai junts a la carrera, com són la computació i les interfícies gràfiques avançades, com poden ser aplicacions mòbils.

FlutterCV és una app Companion del videojoc Animal Crossing New Horizons. Aquestes apps Companion s'encarreguen d'ajudar al jugador a tenir una millor experiència en el joc. En la nostra app en particular, l'aplicació ens ajuda a tenir un registre del progrés en la captura de les diferents classes d'animals que hi ha en el videojoc (més de 200 diferents) per tal de registrar-los en una enciclopèdia i posteriorment exposar-los en el museu. A més, una de les millors funcionalitats és identificar quina obra d'art té el jugador per pantalla i si aquesta és vertadera o es tracta d'una falsificació.
A més, es pot veure una pàgina d'informació detallada per a cada element del videojoc.

# Organització de directoris

El repositori té la següent estructura de directoris:
 - **0-Recursos:** En aquest directori es troben els diferents materials del TFG com els documents d'especificació de l'avaluació, les rúbriques, regles dels informes, etc.
 - **1-Informe Inicial:** Aquesta carpeta conté tots els documents que van sorgir en la primera fase del projecte, com són l'informe inicial o el primer gráfic de Gantt.
 - **2-Primer Progrés:** En aquesta fase es va generar l'informe corresponent, el gràfic de Gantt i els primers models YOLOv5. També es va començar a explorar l'Image Classification (carpeta test_image_class). Dintre de la carpeta YOLOv5 es troben tots els models preentrenats, les runs de train/test, els datasets creats pel projecte (Mock-Art)...
També es pot trobar una primera aproximació d'aplicació al directori FlutterAppDraft, on es va desenvolupar un prototip per probar l'inclusió dels models a l'ecosistema de Flutter
 - **3-Segon Progrés:** Aquesta secció conté l'OCR Cloud amb totes les implementacions necessàries (CustomOCR), l'API de Flask per fer servir l'OCR (ML_API), l'aplicació final cloud (final_app) i l'aplicació de prova per aplicar l'ocr local (flutter_app_ocr). A més, es poden trobar tant l'informe del segon progrés com el diagrama de Gantt.
 - **4-Informe Final:** Aquest directori conté l'aplicació local final (final_local_app) així com l'informe final del TFG.
 - **5-Poster:** Tot el material necessari pel poster.
 - **6-Dossier:** Tot el material generat pel dossier i el vídeo demostració de l'aplicació.

# Vídeo Demostració

[![Vídeo Demostració](https://img.youtube.com/vi/-UW04IGZFZM/0.jpg)](https://www.youtube.com/watch?v=-UW04IGZFZM)

# Instal·lació i ús
- ## Desenvolupadors
    Tot i que el projecte no s'ha desenvolupat amb la idea de tenir l'opció de descarregar-se el projecte i afegir funcionalitats o tocar el codi, es poden instal·lar les dependències necessàries i obrir el projecte. Hi ha dos components principals a instal·lar:
  - ### Instal·lació de YOLOv5
    1. Clona el repositori oficial de [YOLOv5](https://github.com/ultralytics/yolov5).
    2. Clona aquest repositori.
    3. Instal·la les dependencies de l'arxiu requirements de YOLO en un virtual environment.
    4. Ja pots aplicar inferencies sobre imatges utilitzant qualsevol entrenament de la carpeta /runs o directament entrenar el model amb dades o paràmetres a la teva elecció. Per a més informació consultar la [documentació oficial](https://github.com/ultralytics/yolov5/wiki) de YOLOv5.
  - ### Instal·lació de Flutter
    1. Clona aquest repositori.
    2. Segueix les instruccions del tutorial oficial per instal·lar [Flutter](https://docs.flutter.dev/get-started/install).
    3. Obre un terminal i executa la comanda "flutter pub get" per instal·lar totes les dependències necessàries.
    4. Ja pots editar qualsevol aspecte de l'aplicació des de l'IDE escollit.
- ## Usuaris App
  L'aplicació local es pot descarregarà des d'aquest [link](https://drive.google.com/file/d/18IOo73kr5DCP5pNnu42qTavsvXjFgEwk/view?usp=sharing). Aquesta és l'aplicació d'Android. La versió d'iOS es pot exportar en qualsevol moment, però al no tenir cap dispositiu d'Apple no es pot exportar, ja que per polítiques d'Apple és una condició obligatòria.

  Si es vol instal·lar en un dispositiu d'Apple, s'haurà de seguir les instruccions per importar tot el conjunt de Flutter per instal·lar una versió Debug, connectant el dispositiu mòbil a l'ordinador.
 
 # Arquitectura models d'IA
 
 La primera versió dels models que s'han desenvolupat feien ús de l'arquitectura YOLOv5l, que era una de les més potents, però els resultats no reflectien la capacitat de còmput requerida. Per això es va canviar a una YOLOv5s6, amb l'avantatge que utilitza imatges de 1280 x 1280 píxels en contra dels 640 x 640 píxels de l'arquitectura estàndard. Aquest canvi va ajudar molt sobretot perquè el model responia millor davant els petits detalls de les obres d'art.
 <div style="text-align:center"><img src="6- Dossier/arquitectura yolo.png"/></div>
 
 - ## YOLOv5 per Object Detection (Cloud)
    S'ha utilitzat YOLOv5 per els dos models que s'han desenvolupat en el projecte per Object Detection en la versió Cloud de l'aplicació.
  - ### Detecció d'obres d'art
    <div style="text-align:center"><img src="6- Dossier/yolov5.jpg" width=500/></div>
    S'ha utilitzat la versió YOLOv5s6, especial per a imatges amb dimensions de 1280 x 1280 píxels. El model rep la imatge a través de l'API desenvolupada sense processar amb les dimensions de la imatge que captura la càmera. Es processa per convertir-la en una imatge amb relació 1:1 amb mida 1280 x 1280 píxels, mantenint tota la informació sense fer retalls a la imatge, només deformant-la.
    
    Aquestes dades passen per totes les capes de la xarxa per retornar l'etiqueta, les dimensions de la zona on està l'obra i la seva confiança d'encert. Aquest model pot trobar fins a 100 figures diferents en una mateixa imatge, però quan el model s'aplica a l'API per l'aplicació es configura per retornar només la predicció amb més confiança.
  - ### Detecció de bombolles de text
    <div style="text-align:center"><img src="6- Dossier/yolov51.png"/></div>
    Aquest model s'encarrega d'identificar les bombolles de text que es troben a pantalla per després aplicar l'algorisme d'OCR només en aquestes regions. Això fa que el programa sigui molt més eficient i s'aconsegueixin millors resultats. D'igual manera que l'anterior, la xarxa rep una imatge a través de l'API sense processar. Després de processar-la passa per les capes de la xarxa i retorna les regions en coordenades, la classe "text_bubble" i la confiança.
    
    Aquestes dades es passen al següent pas del programa, l'OCR.
 - ## SSDMobileNetV2 per Image Classification (Local)
    Aquest model de xarxa neuronal s'ha utilitzat en la versió local de l'aplicació. Com que un telèfon mòbil té una capacitat de còmput molt més petita i la compatibilitat amb els fitxers dels models YOLOv5 exportats és nul·la, s'han buscat uns altres models per aquesta tasca. Ja que l'usuari només vol la predicció en forma de nom de l'obra, s'ha canviat d'Object Detection (classe + regió) a Image Classification (classe). La imatge processada ara és de mida 224 x 224 píxels, és molt menys demandant, però els resultats no són tan bons. Tot i això, els tests donen un 87% de precisió.
    
- ## OCR Cloud - EasyOCR
  En la implementació Cloud d'OCR, les dades a tractar es recullen del resultat del model d'Object Detection per a zones de text. L'EasyOCR genera el text de les regions que s'han enviat del pas anterior, retornant les coordenades del text, el text interpretat i la confiança de la predicció.
  
  Amb aquestes dades es genera l'insecte, el peix o la criatura marina del qual pertany el text i se li envia a l'aplicació a través de l'API. 
- ## OCR Local - ML Kit
  En aquesta implementació l'encarregat d'interpretar el text que apareix per pantalla és ML Kit desenvolupat per Google. Com que el dispositiu que farà les inferències té menys capacitat de còmput, el mateix mòdul farà la funció de detecció de text per a tota la pantalla, en comptes de primer aplicar un pas previ per detectar les bombolles de text. Independentment d'aquest fet, els resultats són molt satisfactoris.

# Ús de l'aplicació
  La primera pantalla es mostra en obrir l'aplicació és la de Home. En aquesta pantalla es veuen elements generals com el dia, el progrés del jugador en les diferents categories i les espècies noves del mes actual.
  
  A partir d'aquí, es pot moure a qualsevol pantalla amb l'ajuda de la barra de navegació inferior. Depenent de la icona que es premi, es mourà fins a la pantalla de llista de la categoria seleccionada. Des d'aquesta pantalla es pot accedir a qualsevol pantalla d'informació de l'ítem que es premi. A més, des d'aquestes pantalles es pot accedir a les funcions especials amb intel·ligència artificial. Des de les icones de càmera o galeria, l'aplicació farà inferència de les imatges que es passin i respondrà amb la predicció feta. Si és correcte, s'obrirà la pantalla d'informació de la predicció.
  
  En la següent secció es poden veure les diferents pantalles i funcions de l'aplicació.

# Captures de l'aplicació

<div style="text-align:center; height: 300px;"><img src="6- Dossier/screens1.png" /></div>
<div style="text-align:center; height: 300px;"><img src="6- Dossier/screens2.png" /></div>
<div style="text-align:center; height: 300px;"><img src="6- Dossier/screens3.png" /></div>
<div style="text-align:center; height: 300px;"><img src="6- Dossier/screens4.png" /></div>
<div style="text-align:center; height: 300px;"><img src="6- Dossier/screens5.png" /></div>

