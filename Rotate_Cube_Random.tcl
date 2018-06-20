#for {set i 1} { $i <= 5000} {incr i} {
set r 1.0 ; # RADIUS OF THE SPHERE
set water_residue [lsort -unique [[atomselect top all] get residue]] ;# GETING THE UNIQUE RESIDUE FOR ALL THE MOLECULES AND ARRANGE IT
foreach residue $water_residue { ; # LOOPING OVER ALL THE RESIDUE ONE-BY-ONE
##-----THIS IS THE PART OF THE CODE TO DISTRIBUTE UNIFORM OINTS ON SPHERE-----##
  	set s 10.0 
		while {$s >=1.0} {
			set a [expr 2.0*rand()-1.0] ; # GENERATING RANDOM NO BETWEEN 1 AND -1
			set b [expr 2.0*rand()-1.0]
			set s [expr $a*$a + $b*$b]
			set s1 [expr $s]
		}
#puts "$a $b $s"
	set s [expr 2.0*sqrt(1.0-$s)]
	set a1 [expr $a*$s*$r]
	set b1 [expr $b*$s*$r]
	set c1 [expr 1.0-2.0*$s1*$r]
	puts " {C           }$a1 $b1 $c1"
	set theta [expr 57.2985*acos($c1/$r)]  ; # CONVERTING RADIAN TO ANGLE BECAUSE VMD USES DEGREE TO ROTATE ABOUT AN AXIS 
	set phi   [expr 57.2985*atan($b1/$a1)]
##------------------ABOVE PART OF THE CODE ENDS HERE----------------------------##
#uts "$theta $phi"
	set all [atomselect top "residue $residue"]
	set coor1 [measure center $all]
	$all move [ transaxis z $theta]
	$all move [ transaxis x $phi]
	set coor2 [measure center $all]
	set coor3 [vecsub $coor1 $coor2] ; # ROTATING AND THEN BRINGING BACK THE MOLECULE TO INITIAL POSITION
	$all moveby $coor3


}
#}
