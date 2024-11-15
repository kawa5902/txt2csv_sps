#!/bin/bash

# PISA 2000 SCH file
python3 txt2csv_sps.py intscho.txt PISA2000_SPSS_school_questionnaire.sps pisa2000sch

sleep 1

# TIMSS 1995 ASG file
python3 txt2csv_sps.py ASGJPN1.DAT ASGCONTR.SPS timss1995asgjpn
