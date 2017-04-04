#!/usr/bin/python

# Script that takes a .json file that documents Intel's performance counting
# events for a specific architecture
#
# Quick note: for offcore events, there are two listings for event codes. We
#   only keep the first one because the different one is for a different
#   architecture? I have taken pictures of the Intel documentation for this
#   and they are located in the subdirectory offcore

import json
from pprint import pprint

json_file = open("Haswell_core_V25.json")
json_data = json.load(json_file)

example = open('myfile_data', 'a+')
dict_ent = ""
event = ""
umask = ""
event_code = ""

for i in range(len(json_data)): 
  dict_ent = json_data[i]
  event = dict_ent["EventName"].encode('ascii','ignore') #remove u'
  event = event.replace(".","_") #change . to _
  umask = dict_ent["UMask"].encode('ascii','ignore') 
  event_code = dict_ent["EventCode"].encode('ascii','ignore')
  event_code = event_code.replace("0x","") #remove 0x
  event_code = event_code[0:2] #take only first code
  example.write("#define " + event + " " + umask + event_code + "\n")

example.close()
