# -*- coding: utf-8 -*-
"""
Created on Wed Aug 17 11:02:55 2022

@author: mccarw
"""
import numpy as np
import os
import argparse
from Cluster_input_parser import Parse_input


parser = argparse.ArgumentParser()
parser.add_argument("-pt","--Patient_number",type=str,default="001")
parser.add_argument("-c","--Case_number",type=int,default=1)
args = parser.parse_args()

# Function to compile the total number of counts and the total 
# sensitivity of each run into text files
def combine_histories_sensitivitites(file_prefex):
    
    def find_line_num(string_array):
        line_num1 = 0;
        line_num2 = 0;
        #print(len(string_array))
        for i in range(0,len(string_array)):
            line_hold = string_array[i]
            if line_hold[1:13]=='PhotonEnergy':
                line_num1 = i
            if line_hold[1:20]=='Sensitivity Cpm/uCi':
                line_num2 = i
        return [line_num1,line_num2]
            
            
    photons = np.zeros(10,dtype='int') 
    sensitivity = np.zeros(10,dtype='f')
    for i in range(1,11):
        a=open(file_system_head+'SIMIND/' + file_prefex + str(i)+'.res','r')
        lines = a.readlines()
        a.close()
        line_nums = find_line_num(lines)
        line_hold = lines[line_nums[0]]
        photons[i-1] = line_hold[64:]
        line_hold = lines[line_nums[1]]
        sensitivity[i-1] = line_hold[22:]
    return [photons,sensitivity]


def Justin_modified(sim_sensitivity,sim_counts,percision,number_of_projections,iwin,file_prefex):
    ntimes = 3
    cntscl = 10
    psize = 0.23976
    colsens = 100

    c = np.zeros((percision,percision,number_of_projections),dtype=float)
    for i, v in enumerate(sim_sensitivity):
        scl = colsens/sim_sensitivity[i]
        simscl = sim_counts[i]/(ntimes*cntscl)
        scale = (simscl*psize**3*scl)/number_of_projections
        
        if iwin==1:
            b = np.fromfile(file_system_head+'SIMIND/' + file_prefex+'256_run12_'+str(i+1)+'_tot_w1.a00',dtype=np.float32)
        elif iwin==2:
            b = np.fromfile(file_system_head+'SIMIND/' + file_prefex+'256_run12_'+str(i+1)+'_tot_w2.a00',dtype=np.float32)
        else:
            print('Select window 1 or 2')
        b = np.reshape(b,(percision,percision,number_of_projections),order='F')
        
        c = c + scale*b*(1/len(sim_sensitivity))
        #print(len(sim_sensitivity))
    return c    
            
            
      

Case_num = args.Case_number
pt_num = args.Patient_number

file_system_head = '../pt'+str(pt_num)+'/'
Inputs = Parse_input(file_system_head,1)
#print(Inputs['Percision'])
#print(type(Inputs['Percision']))
percision = Inputs['Percision']
file_list = Inputs['file_list']
number_of_projections = Inputs['Number_of_Projections']




#file_system_head = "../"            
            
            







os.system("cp "+file_system_head+"SIMIND/bgd256_run12_1.cor "+file_system_head+"Projections/bgd256_run12_1.cor")
#os.system("copy SIMIND\bgd256_run12_1.cor Projections\bgd256_run12_1.cor")
for i in range(0,len(file_list)):
    print(file_list[i])
    line = combine_histories_sensitivitites(file_list[i]+'256_run12_')
    np.savetxt(file_system_head+'Projections/'+file_list[i]+'_simcnts.txt',line[0],fmt='%d')
    np.savetxt(file_system_head+'Projections/'+file_list[i]+'_sens.txt',line[1],fmt='%f')

    combined_projection = Justin_modified(line[1],line[0],percision,number_of_projections,1,file_list[i])
    combined_PP_projection_towrite = np.reshape(combined_projection,(-1),order='F')
    combined_PP_projection_towrite.astype('float32').tofile(file_system_head+'Projections/'+file_list[i]+'256_ppsc.prj')

    combined_projection = Justin_modified(line[1],line[0],percision,number_of_projections,2,file_list[i])
    combined_projection_towrite = np.reshape(combined_projection,(-1),order='F')
    combined_projection_towrite.astype('float32').tofile(file_system_head+'Projections/'+file_list[i]+'256_sc.prj')

















