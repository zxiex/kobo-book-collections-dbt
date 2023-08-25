{%- macro book_folder_name(book_path) -%}

substring({{book_path}}, 21, INSTR(substring({{book_path}}, 21, 40), '/') - 1)

{%- endmacro -%}
