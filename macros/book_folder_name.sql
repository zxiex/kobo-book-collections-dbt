{%- macro book_folder_name(BookID) -%}

substring(BookID, 21, INSTR(substring(BookID, 21, 40), '/') - 1)

{%- endmacro -%}