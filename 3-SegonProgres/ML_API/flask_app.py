from random import random
import flask
import io
import string
import time
import os
import torch
import numpy as np
import tensorflow as tf
from PIL import Image
from flask import Flask, jsonify, request

#model = tf.keras.models.load_model("best1.pt")
#print(model)

model = torch.hub.load('ultralytics/yolov5', 'custom', path='../../2-PrimerProgres/YOLOv5/runs/train/exp80/weights/best.pt')

def predict_result(img):
    model.conf = 0.2
    model.max_det = 5
    results = model(img)

    #results.print()
    #results.show()
    #print(results.pandas().xyxy[0])
    pred_name = results.pandas().xyxy[0].name[0]
    pred_conf = results.pandas().xyxy[0].confidence[0]
    return (pred_name, round(pred_conf,3))

app = Flask(__name__)

@app.route('/predict', methods=['POST'])
def infer_image():
    #catch the image file from a POST request
    if 'file' not in request.files:
        return "Please try again. The image doesn't exist"
    
    file = request.files.get('file')
    if not file:
        return
    
    #read the image
    img_bytes = request.files['file']
    img = Image.open(img_bytes)

    #return on a json format
    pred_name, pred_conf = predict_result(img)
    return jsonify(prediction = pred_name, confidence = pred_conf)

@app.route('/', methods=['GET'])
def index():
    return 'Machine Learning Inference'



if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')