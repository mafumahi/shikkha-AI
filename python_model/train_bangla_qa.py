import json
import tensorflow as tf
from tensorflow.keras import layers
from sklearn.model_selection import train_test_split
from tensorflow.keras.preprocessing.text import Tokenizer
from tensorflow.keras.preprocessing.sequence import pad_sequences

with open("bangla_qa.json", "r", encoding="utf-8") as f:
    data = json.load(f)

questions = [x["question"] for x in data]
contexts  = [x["context"] for x in data]
answers   = [x["answer"] for x in data]

inputs = [q + " [SEP] " + c for q, c in zip(questions, contexts)]

tokenizer = Tokenizer(num_words=10000, oov_token="<OOV>")
tokenizer.fit_on_texts(inputs + answers)

X = tokenizer.texts_to_sequences(inputs)
y = tokenizer.texts_to_sequences(answers)

X = pad_sequences(X, maxlen=50)
y = pad_sequences(y, maxlen=5)

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2)

model = tf.keras.Sequential([
    layers.Embedding(10000, 64, input_length=50),
    layers.Bidirectional(layers.LSTM(64)),
    layers.Dense(64, activation='relu'),
    layers.Dense(5, activation='softmax')
])

model.compile(loss='sparse_categorical_crossentropy', optimizer='adam', metrics=['accuracy'])
model.fit(X_train, y_train, epochs=20, validation_data=(X_test, y_test))
model.save("bangla_qa_model.h5")
  
