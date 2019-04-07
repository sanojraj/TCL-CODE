# Choose the value of "Choose" from the following number
#1 - 3D cube with atoms at hexagon
#2 - 3D cube points in FCC lattice
#3 - 3D cube points equally spaced
#4 - Equidistant points inside the sphere
#5 - Random points inside the sphere
#6 - Equidistant and random points on cylinder
set choose 2
set a 1
set radius 2.0
set crd []
set sp_x 0.0
set sp_y 0.0
set sp_z 0.0
if {$choose ==1} {
set seperation 190.0
	for {set j 0} { $j<8} {incr j} {
	if {$j%2 ==0} {
	set sp_z 0.0
	}
	if {$j%2 ==1} {
	set sp_z [expr $seperation/2.0]
	}
		for {set l 0} {$l < 8 } {incr l} {
        	set sp_z [expr $sp_z+$seperation]
		set coord [concat "$sp_x $sp_y $sp_z"]
		lappend crd $coord
		set tempy $sp_y
		set tempz $sp_z
			for {set i 0} { $i<0} {incr i} {
				if {$i%2==0} {
				set sp_z [expr $tempz -($seperation/2.0)]
				set sp_y [expr $tempy -(($seperation/2.0)/1.732)]
				}
				if {$i%2==1} {
				set sp_z  $tempz
				set sp_y  $tempy
				}
			set sp_x [expr $sp_x+171.0]
			set coord [concat "$sp_x $sp_y $sp_z"]
			lappend crd $coord
			}
		set sp_y $tempy
		set sp_z $tempz
		set sp_x 0.0
		}
	set sp_y [expr $sp_y+(($seperation*1.732) /2)]
	}
}
#########################################################
if {$choose ==2} {
set seperation 135.0
	for {set j 0} { $j<16} {incr j} {
	if {$j%2 ==0} {
	set sp_z 0.0
	}
	if {$j%2 ==1} {
	set sp_z [expr $seperation]
	}
		for {set l 0} {$l < 8 } {incr l} {
	        set sp_z [expr $sp_z+$seperation*2.0]
		set coord [concat "$sp_x $sp_y $sp_z"]
		lappend crd $coord
		set tempy $sp_y
		set tempz $sp_z
			for {set i 0} { $i<16} {incr i} {
			if {$i%2==0} {
			set sp_z [expr $tempz -$seperation]
			set sp_y [expr $tempy -0.0]
			}
			if {$i%2==1} {
			set sp_z  $tempz
			set sp_y  $tempy
			}
		set sp_x [expr $sp_x+$seperation]
		set coord [concat "$sp_x $sp_y $sp_z"]
		lappend crd $coord
			}		
	set sp_y $tempy
	set sp_z $tempz
	set sp_x 0.0
		}	
	set sp_y [expr $sp_y+$seperation]
	}
}
##########################################################
if {$choose ==3} {
	for {set j 0} { $j<30} {incr j} {
		for {set l 0} {$l < 10 } {incr l} {
	        set sp_z [expr $sp_z+210.0]
		set coord [concat "$sp_x $sp_y $sp_z"]
		lappend crd $coord
			for {set i 0} { $i<0} {incr i} {
		        set sp_x [expr $sp_x+210.0]
			set coord [concat "$sp_x $sp_y $sp_z"]
			lappend crd $coord
#			puts $coord
			}
		set sp_x 0.0
		}	
	set sp_y [expr $sp_y+210.0]
	set sp_z 0.0
	}
}
#######################################################
if {$choose ==4} {
	for {set l 0} {$l < 2000} {incr l} {
	 set num_pts [expr int((4.0*3.14*$radius*$radius)/(210.0*210.0))]
	 set PI 3.1415926535897931
         set dlong [expr $PI*(3-sqrt(5.0))]
         set dz [expr 2.0/$num_pts]
         set long 0.0
         set z [expr 1-$dz/2]
         set sphere {}
		  for {set i 0 } {$i < $num_pts} {incr i} {
	     	  set r [expr sqrt(1-$z*$z)]
		  set sp_x [expr $radius*cos($long)*$r]
		  set sp_y [expr $radius*sin($long)*$r]
		  set sp_z [expr $radius*$z]
		  set z [expr $z-$dz]
		  set long [expr $long+$dlong]
		  set a  [llength $crd]
		     if {$a >1867} {
		        break
     		     }
		  set coord [concat "$sp_x $sp_y $sp_z"]
		  lappend crd $coord
  	          }
	set radius [expr $radius+210.0]
	}	
}
#####################################################################
if {$choose == 5} {
	for {set l 0} {$l < 2000} {incr l} {
	set num_pts [expr int((4.0*3.14*$radius*$radius)/(210.0*210.0))]
		for {set i 0 } {$i < $num_pts} {incr i} {
		set phi [expr 360.0 - rand()*360.0]
		set costheta [expr 2.0*rand() - 1.0]
		set u [expr rand()]
		set theta [expr acos($costheta)]
		set r [expr $radius*$u**(1/3)]
		set sp_x [expr $r*sin($theta)*cos($phi)]
		set sp_y [expr $r*sin($theta)*sin($phi)]
		set sp_z [expr $r*cos($theta)]
		set a  [llength $crd]
		#puts $a
		if {$a >1867} {
			break
		}
		set coord [concat "$sp_x $sp_y $sp_z"]
		lappend crd $coord
		}
	set radius [expr $radius+210.0]
	}
}
###################
if {$choose ==6} {
        set long 0.0
        for {set l 0} {$l < 30} {incr l} {
         set num_pts 20
         #set num_pts [expr int((4.0*3.14*$radius*$radius)/(210.0*210.0))]
         set PI 3.1415926535897931
	 #equidistant points on the disk
         set dlong [expr 2.0*$PI/$num_pts]
	 #random points on the disk
        # set dlong [expr rand()*2*$PI]
         set dz [expr 2.0/$num_pts]
       #  set long 0.0
         set z [expr 1-$dz/2]
         set sphere {}
                  for {set i 0 } {$i < $num_pts} {incr i} {
                  set r [expr sqrt(1-$z*$z)]
                  set sp_x [expr 170.0*cos($long)]
                  set sp_y [expr 170.0*sin($long)]
                  set sp_z [expr $l*80.0]
                  set z 0.0
                  set long [expr $long+$dlong]
                  set a  [llength $crd]
                     if {$a >800} {
                        break
                     }
                  set coord [concat "$sp_x $sp_y $sp_z"]
                  lappend crd $coord
                  }
         if {$l%2 ==0} {
        set long [expr $dlong/2.0]
        }
         if {$l%2 ==1} {
        set long 0.0
        }
        set radius [expr $radius+210.0]
        }
}

######################################
set a  [llength $crd]
puts "$a"
#puts $crd
set ion_residue [lsort -unique [[atomselect top "segname CORE"] get residue]]
	foreach residue $ion_residue pt $crd {
	set atoms [atomselect top "residue $residue"]
	set C [atomselect top "residue $residue and type FC"]
	set Ccrd [measure center $C]
	$atoms moveby [vecscale [vecsub $Ccrd $pt] -1]
	}
set sel1 [atomselect top all]
$sel1 moveby [vecscale -1.0 [measure center $sel1]]
puts [measure center $sel1]
#source Rotate_Cube_Random.tcl
