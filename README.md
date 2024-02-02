# ftwrangler (Fine-Tuning Wrangler) 

ftwrangler is a tool for processing ordinary text documents (like .docx) into documents that can be used for training fine-tuned AI models.  

## Sample Usage

1. Create a series of .docx documents where the content of the document represents how you want the AI to respond, and the name of the document represents what the initial prompt would be.  
2. Group them in a folder within the prompts folder (e.g. "/prompts/sample/").  
3. To process all of the folders, run the command "./wrangle.sh your_output_file_name.jsonl".  
4. You can use the resultant file to train fine-tuned models, e.g. on OpenAI's API.  

## Scope 

Requires pandoc and jq.  

Currently, ftwrangler only processes docx into LaTeX formatting.  This will hopefully be extended in the future.  Pull requests are welcome.  