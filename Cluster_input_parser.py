# -*- coding: utf-8 -*-
"""
Created on Tue Sep  6 09:31:48 2022

@author: mccarw
"""

def Parse_input(path_to_pt_dir,case_num_call):
    
    def find_input(line_hold):

        
        list_hold = line_hold.split()
        if list_hold[0]=='Case_number:':
            return list_hold
        if list_hold[0]=='Percision:':
            return list_hold
        if list_hold[0]=='Number_of_Projections:':
            return list_hold
        if list_hold[0]=='file_list:':
            return list_hold
        if list_hold[0]=='add_noise:':
            list_hold[1] = list_hold[1] == 'True'
            return list_hold
        for j in range(0,10):
            str_hold = 'Case'+str(j+1)+':'
            if list_hold[0]==str_hold:
                return list_hold
        for j in range(0,10):
            str_hold = 'Scale'+str(j+1)+':'
            if list_hold[0]==str_hold:
                return list_hold
        return list_hold



        
            
            
    a=open(path_to_pt_dir+'Cluster_Recon_Input.txt','r')
    lines = a.readlines()
    a.close()
    Input_dict = {'path':path_to_pt_dir}
    for i in range(0,len(lines)):
        line_hold = lines[i]
        if line_hold=='\n':
            continue
        out = find_input(line_hold)
        print(out)
        tag = out[0]
        if tag[0:4]=='Case':
            if tag[4:6]=='10' and case_num_call == 10:
                Input_dict['scales'] = out[1:]
            elif tag[4]==str(case_num_call) and tag[4:6]!='10':
                Input_dict['scales'] = out[1:]
            continue
        elif tag[0:5]=='Scale':
            if tag[5:7]=='10' and case_num_call == 10:
                Input_dict['noise_scale'] = out[1:]
            elif tag[5]==str(case_num_call) and tag[5:7]!='10':
                Input_dict['noise_scale'] = out[1:]
        elif len(out[1:])==1 and not isinstance(out[1:],bool):
            if float(out[1]) > 1000: #Check if counts or noise scale
                Input_dict[tag[:-1]] = int(out[1])
            else:
                Input_dict[tag[:-1]] = int(out[1])
        else:
            Input_dict[tag[:-1]] = out[1:]
    print(Input_dict)
    return Input_dict







