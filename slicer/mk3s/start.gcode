M862.3 P "[printer_model]" ; printer model check
M862.1 P[nozzle_diameter] ; nozzle diameter check
M115 U3.9.3 ; tell printer latest fw version
G90 ; use absolute coordinates
M83 ; extruder relative mode

; Don't change E values below. Excessive value can damage the printer.
{if print_settings_id=~/.*(DETAIL @MK3|QUALITY @MK3).*/}M907 E430 ; set extruder motor current{endif}
{if print_settings_id=~/.*(SPEED @MK3|DRAFT @MK3).*/}M907 E538 ; set extruder motor current{endif}

; warm up without oozing
M104 S155 ; set extruder temp to only 155 to prevent oozing. 
M140 S[first_layer_bed_temperature] ; set bed temp
G28 W ; home all without mesh bed level
G1 X10 Y-3 Z150 F2000; move extruder above bed in front for easier cleaning
M109 S155 ; wait for extruder temp to hit 155.
M190 S[first_layer_bed_temperature] ; wait for bed temp.
G28 ; home + mesh bed level
G1 Z2 F2000 ; Lift a little to prevent heating while .2mm from the bed
M104 S[first_layer_temperature] ; set extruder temp to real temp now. 
M109 S[first_layer_temperature] ; wait for extruder temp. 
G1 Z0 F2000 ; set back down after extruder is at temp.

; long purge line
G1 Y-3.0 F1000.0 ;go outside print area
G1 Z0.4 F1000.0
G1 X55.0 F2000.0
G1 Z0.3 F1000.0
G92 E0.0
G1 X240.0 E25.0 F2200.0
G1 Y-2.0 F1000.0
G1 X55.0 E25 F1400.0
G1 Z0.20 F1000.0
G1 X5.0 E4.0 F1000.0

G92 E0.0; Reset extruder relative position to 0.
M221 S{if layer_height<0.075}100{else}95{endif}
