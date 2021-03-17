;disable all heaters
{% snippet 'disable_hotends' %}
{% snippet 'disable_bed' %}

M106 S0 ; disable fan

G91 ; Set relative mode
G1 Z20 ; Move print head up

G90 ; set absolute mode
G1 X0 Y200 ; "home" X axis and move print forward

M84 ; disable motors
