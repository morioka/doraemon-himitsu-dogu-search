import json

import numpy as np
import sentents_bert

from data import HIMITSU_DOGU_DATA_PATH, MODEL_NAME, SENTENTS_VECTOR_DATA_PATH


def main():
    model = sentents_bert.SentenceBertJapanese(MODEL_NAME)

    with open(HIMITSU_DOGU_DATA_PATH, "r") as f:
        himitsu_dogus = json.load(f)
    # NOTE: Combine name and description to increase the recall for query
    himitsu_docs_descriptions = [
        himitsu_dogu["name"] + " " + himitsu_dogu["description"] for himitsu_dogu in himitsu_dogus
    ]
    print("Start BERT encode")

    n = 320
    himitsu_docs_data = [ himitsu_docs_descriptions[idx: idx + n] for idx in range(0,len(himitsu_docs_descriptions), n)]
    sentence_embeddings = np.vstack([model.encode(himitsu_docs, batch_size=32).cpu().detach().numpy() for himitsu_docs in himitsu_docs_data])
    print("End BERT encode")

    print("Start serialization as numpy file")
    np.save(SENTENTS_VECTOR_DATA_PATH, sentence_embeddings)
    print("End serialization")


if __name__ == "__main__":
    main()
