#!/bin/bash
python3 scripts/check_requirements.py requirements.txt
if [ $? -eq 1 ]
then
    echo Installing missing packages...
    pip install -r requirements.txt
fi

export accessToken=$(az account get-access-token --resource https://cognitiveservices.azure.com | jq -r .accessToken)
sed -i "s/OPENAI_API_KEY=.*/OPENAI_API_KEY=$accessToken/" ./.env

python3 -m autogpt $@
read -p "Press any key to continue..."