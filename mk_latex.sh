#!/bin/zsh

# DIRECTORY TO CONVERT 

if [[ ! -d "${1}" ]]; then 
    echo "CONVERT PROMPTS IN A DIR TO LATEX"; 
    echo "ERR: NEED ONE ARG SPECIFYING DIR"; 
    exit; 
fi 

# DIRECTORY TO CONVERT TO 

dn_tex=$(echo "${1%/}" | sed -E "s|^[^/]+|3.frags|"); 
rm -r "${dn_tex}"; 
mkdir -p "${dn_tex}"; 

# ITERATE OVER FILES 

for f in "${1}"/*.docx; do 

    # CONVERT 

    echo "CONVERTING TO LATEX: ${f}…"; 
    fn_tex=$(basename "${f}" | sed -E "s|docx$|tex|"); 
    out_file="${dn_tex}/${fn_tex}"
    pandoc "${f}" -o "${out_file}"; 

    # REMOVE WHITESPACE 

    sed -i '' -E 's|^$|\\par |' "${out_file}"; 
    sed -i '' -E 's|"|``|g' "${out_file}"; 
    tr '\n' ' ' < "${out_file}" > "${out_file}-t" && mv "${out_file}-t" "${out_file}"; 
done 