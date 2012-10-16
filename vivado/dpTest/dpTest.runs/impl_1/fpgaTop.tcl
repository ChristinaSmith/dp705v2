proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

start_step init_design
set rc [catch {
  create_msg_db init_design.pb
  set_param iopl.termPlaceClean 1
  read_checkpoint /home/cms/projects/dp705v2/vivado/dpTest/dpTest.runs/synth_1/fpgaTop.dcp
  set_property webtalk.parent_dir /home/cms/projects/dp705v2/vivado/dpTest/dpTest.data/wt [current_project]
  read_xdc /home/cms/projects/dp705v2/vivado/dpTest/dpTest.srcs/constrs_1/imports/dp705v2/kc705.xdc
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
}

start_step opt_design
set rc [catch {
  create_msg_db opt_design.pb
  opt_design 
  write_checkpoint -force fpgaTop_opt.dcp
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
}

start_step place_design
set rc [catch {
  create_msg_db place_design.pb
  place_design 
  catch { report_io -file fpgaTop_io_placed.rpt }
  catch { report_clock_utilization -file fpgaTop_clock_utilization_placed.rpt }
  catch { report_utilization -file fpgaTop_utilization_placed.rpt }
  catch { report_control_sets -verbose -file fpgaTop_control_sets_placed.rpt }
  write_checkpoint -force fpgaTop_placed.dcp
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
}

start_step route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  catch { report_drc -file fpgaTop_drc_routed.rpt }
  catch { report_power -file fpgaTop_power_routed.rpt }
  catch { report_route_status -file fpgaTop_route_status_routed.rpt }
  catch { report_timing_summary -file fpgaTop_timing_summary_routed.rpt }
  write_checkpoint -force fpgaTop_routed.dcp
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
}

