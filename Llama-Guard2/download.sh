#!/usr/bin/env bash

# 设置脚本退出条件
set -e

# 读取URL和模型列表
PRESIGNED_URL="https://download5.llamameta.net/*?Policy=eyJTdGF0ZW1lbnQiOlt7InVuaXF1ZV9oYXNoIjoidXo5N3MyeWkxamJ3eDZpdnpqNjY3ZmYxIiwiUmVzb3VyY2UiOiJodHRwczpcL1wvZG93bmxvYWQ1LmxsYW1hbWV0YS5uZXRcLyoiLCJDb25kaXRpb24iOnsiRGF0ZUxlc3NUaGFuIjp7IkFXUzpFcG9jaFRpbWUiOjE3MTU5NTExOTV9fX1dfQ__&Signature=gNa8-bIKyG-HGDDWCYbWzk%7EL1UTmp-S3XrojNJLAoni3QAtML-1IG6BU6-TOtDekOZ7QX3tWoDRUoCL1Hp4O5jWzO8QnrSqL2qnGcd%7ERvZp8iU6oq8THy5liPBccXd5sdC6AQodzuIrskSrFSBrkO7ZqyH%7E8GzO%7EFy6OOkdcgaCbM5upSSbLYyrnJ507o6ZgwQp25ss0YYUofplUsMIZ%7EWVZiOujEAhl0jtXFL-L6mtX3XovqTtAP-sWSCYxNS8jyLcHMS54b%7EcRY0TkYj7%7EVHhyp4Ryo14HhPOSl0pZkWSL0TRIkETApnmuQPB3AVEhToPPnRtJPb7tq2fsSIu2ew__&Key-Pair-Id=K15QRJLYKIFSLZ&Download-Request-ID=445420878179139"

read -p "Enter the list of models to download without spaces (7B,7B-instruct,13B,13B-instruct), or press Enter for all: " MODEL_SIZE

# 设置目标文件夹路径
TARGET_FOLDER="/e/AI_model_llama/guard2_model/downloaded_models"
mkdir -p "${TARGET_FOLDER}"

if [[ $MODEL_SIZE == "" ]]; then
    MODEL_SIZE="7B,7B-instruct,13B,13B-instruct"
fi

echo "Downloading LICENSE and Acceptable Usage Policy"
curl -L "${PRESIGNED_URL}&/LICENSE" -o "${TARGET_FOLDER}/LICENSE"

# 下载模型文件
IFS=',' read -r -a models <<< "$MODEL_SIZE"
for model in "${models[@]}"; do
    echo "Downloading ${model} model from ${PRESIGNED_URL}&${model}"
    curl -L "${PRESIGNED_URL}&${model}" -o "${TARGET_FOLDER}/${model}"
    if [[ $? -ne 0 ]]; then
        echo "Error downloading ${model} model"
    else
        echo "${model} model downloaded successfully"
    fi
done
