include <BOSL2/std.scad>

$fn = 100;

side_wall_width = 2;
back_wall_width = 1;
front_wall_width = 1;

pcb_width = 24.33;
pcb_depth = 49;
pcb_height = 1.55;

pcb_margin = 0.3;
pcb_inner_height_offset = 4;
pcb_rail_depth = 0.8;

usbc_width = 9.4;
usbc_height = 3.6;
usbc_pcb_offset = 12;

button_hole_diameter = 1.5;
led_hole_diameter = 1.5;

inner_height = 25;

outer_rounding = 1.5;
outer_width = pcb_width + pcb_margin + 2 * side_wall_width - 2 * pcb_rail_depth;
outer_depth = pcb_depth + pcb_margin + back_wall_width;
outer_height = inner_height + 2 * side_wall_width;

inner_width = pcb_width + pcb_margin - 2 * pcb_rail_depth;
inner_depth = pcb_depth + pcb_margin;

cap_rounding = 1;
cap_cutout_height = outer_height - 2 * side_wall_width + 2 * pcb_rail_depth;
cap_cutout_width = outer_width - 2 * side_wall_width + 2 * pcb_rail_depth;
cap_cutout_depth = 1.5;

rj45_cutout_height = 13;
rj45_cutout_width = 15.75;
rj45_right_offset = 2.5;
rj45_lip_height = 1;
rj45_lip_width = 1;

button_cutout_depth = 12;
button_cutout_height = 4.5;

rpi_button_depth_offset = 16;
rpi_center_offset = 4.5;

reset_button_offset = 3.6;
power_button_offset = 9.5;
hdd_led_offset = 15.5;
power_led_offset = 19.8;

signs_enabled = true;
signs_size = 3;
signs_depth = 0.5;

module button_hole() {
  cylinder(h = side_wall_width, d = button_hole_diameter);
}

module led_hole() {
  cylinder(h = side_wall_width + 0.1, d = led_hole_diameter);
}

module pcb() {
  cuboid([pcb_width + pcb_margin, pcb_depth + pcb_margin, pcb_height + pcb_margin]);
}

module box_shell() {
  difference() {
    cuboid(size = [outer_width, outer_depth, outer_height], rounding = outer_rounding, except = [FRONT]);
    fwd(back_wall_width / 2)
      cuboid(size = [inner_width, inner_depth, inner_height], rounding = 0.5, except = [FRONT,BACK]);
  }
}

module cap_cutout() {
  cuboid(size = [cap_cutout_width, cap_cutout_depth, cap_cutout_height], rounding = cap_rounding, except = [FRONT,BACK]);
}

module usbc_hole() {
  rotate([90, 0, 0])
    right((usbc_width - usbc_height) / 2)
      hull() {
        cylinder(h = back_wall_width + 0.2, d = usbc_height);
        left(usbc_width - usbc_height)
          cylinder(h = back_wall_width + 0.2, d = usbc_height);
      }
}

module button_cutout() {
  cuboid([pcb_rail_depth, button_cutout_depth + 0.01, button_cutout_height]);
}

module usb_sign() {
  up(2)
    back((outer_depth - signs_depth) / 2)
      color("red")  
        rotate([180,0,180])
          text3d("PIKVM", h = signs_depth, size = signs_size, spacing = 1.25, orient = BACK, center = true, font = ":style=bold");  
}

module uncapped_box() {
  difference() {
    box_shell();
    fwd(back_wall_width / 2)
      down((inner_height - pcb_height - pcb_margin) / 2 - pcb_inner_height_offset)
          pcb();
    
    back(outer_depth / 2 + 0.1)
      down((inner_height - usbc_height) / 2 - pcb_inner_height_offset - pcb_height - pcb_margin - usbc_pcb_offset)
        usbc_hole();  
    
    fwd((outer_depth - cap_cutout_depth) / 2)
      cap_cutout();
    
    down((inner_height - button_cutout_height) / 2 - pcb_inner_height_offset - pcb_height - pcb_margin)
      fwd((outer_depth - button_cutout_depth) / 2 - cap_cutout_depth)
        left((inner_width + pcb_rail_depth) / 2)
          button_cutout();
    
    back((inner_depth - button_hole_diameter - back_wall_width) / 2 - rpi_button_depth_offset)
      up(inner_height / 2) {
        left(rpi_center_offset)
          button_hole();
        right(rpi_center_offset)
          button_hole();
      }

    down((inner_height - button_cutout_height) / 2 - pcb_inner_height_offset - pcb_height - pcb_margin)
      left(outer_width / 2) {
        rotate([0,90,0]) {
          fwd(outer_depth / 2 - reset_button_offset)
            button_hole();
          fwd(outer_depth / 2 - power_button_offset)
            button_hole();
          fwd(outer_depth / 2 - hdd_led_offset)
            led_hole();
          fwd(outer_depth / 2 - power_led_offset)
            led_hole();
        }
      }
    if (signs_enabled) {
      usb_sign();
    }  
  }
}

module atx_sign() {
  down(10)
    right(2.75)
      fwd(outer_rounding - signs_depth / 2)
        color("red")
          text3d("ATX", h = signs_depth, size = signs_size, spacing = 1.25, orient = FRONT, center = true, font =":style=bold");
}

module cap() {
  difference() {
    union() {
      difference() {
        cuboid(size = [outer_width, outer_rounding + cap_cutout_depth, outer_height], rounding = outer_rounding, except = [BACK]);
        back(cap_cutout_depth) 
          rotate([90,0,0])
            rect_tube(h = cap_cutout_depth, size = [outer_width, outer_height], wall = side_wall_width - pcb_rail_depth, rounding = outer_rounding, irounding = cap_rounding);
        back(cap_cutout_depth / 2) 
          cuboid(size = [cap_cutout_width - 2 * pcb_rail_depth, cap_cutout_depth, cap_cutout_height - 2 * pcb_rail_depth], rounding = 0.5, except = [FRONT,BACK]);
        right(rj45_right_offset)
          down((inner_height - rj45_cutout_height) / 2 - pcb_inner_height_offset - pcb_height - pcb_margin)
            fwd(outer_rounding / 2)
              cuboid([rj45_cutout_width, outer_rounding + 0.1, rj45_cutout_height]);
      }
      right(rj45_right_offset)
        down((inner_height - rj45_cutout_height) / 2 - pcb_inner_height_offset - pcb_height - pcb_margin)
          back(outer_rounding / 2 + 0.25)
            rotate([90,0,0])
              rect_tube(h = outer_rounding + rj45_lip_height, size = [rj45_cutout_width + rj45_lip_width * 2, rj45_cutout_height + rj45_lip_width * 2], wall = rj45_lip_width);
    }
    back(cap_cutout_depth / 2)
      down((inner_height - pcb_height - pcb_margin) / 2 - pcb_inner_height_offset)
        cuboid([pcb_width + pcb_margin, cap_cutout_depth, pcb_height + pcb_margin]);
    if (signs_enabled) {
      atx_sign();
    }
  }
}

uncapped_box();

fwd(outer_depth / 2 + 10)
  cap();

if (signs_enabled) {
  usb_sign();
  fwd(outer_depth / 2 + 10)
    atx_sign();
}  
