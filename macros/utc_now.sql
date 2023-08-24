{%- macro utc_now() -%}

strftime('%Y-%m-%dT%H:%M:%SZ', datetime('now', 'utc'))

{%- endmacro -%}