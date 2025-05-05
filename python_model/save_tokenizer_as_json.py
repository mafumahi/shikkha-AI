import pickle
import json
with open("tokenizer.pkl", "rb") as f:
    tokenizer = pickle.load(f)
tokenizer_json = tokenizer.to_json()
with open("tokenizer.json", "w", encoding="utf-8") as f:
    f.write(tokenizer_json)
