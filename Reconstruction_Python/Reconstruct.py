# -*- coding: utf-8 -*-
"""
Created on Thu Sep  1 08:30:18 2022

@author: mccarw
"""
import numpy as np
import random as rand
import os
import subprocess
import shutil
from Cluster_input_parser import Parse_input
import argparse

parser = argparse.ArgumentParser()
parser.add_argument("-pt","--Patient_number",type=str,default="002")
parser.add_argument("-c","--Case_number",type=int,default=1)
parser.add_argument("-an","--Add_Noise",type=bool,default=None)
parser.add_argument("-cn","--Contrast",type=int,default=10)
parser.add_argument("-rn","--Recon_number",type=int,default=1)
args = parser.parse_args()

def add_projections(file_list,dim,slices,scales,contrast_in):
    Photopeak = np.zeros(dim*dim*slices,dtype=(np.float32))
    Scatter = np.zeros(dim*dim*slices)
    for i, file_head in enumerate(file_list):

        if i > 4:
            contrast = contrast_in
        else:
            contrast = 1


        Data_hold = np.fromfile(file_system_head+'Projections/'+file_head+'256_ppsc.prj',dtype=np.float32)
        Photopeak = Photopeak + contrast*scales[i]*Data_hold
        
        Data_hold = np.fromfile(file_system_head+'Projections/'+file_head+'256_sc.prj',dtype=np.float32)
        Scatter = Scatter + contrast*scales[i]*Data_hold
    return [Photopeak,Scatter]
    
def extract_projection(proj256,xshift,yshift):
    proj256=np.reshape(proj256,(percision,percision,120),order='F')
    proj128_hold = proj256[(128-64+xshift):(128+64+xshift),(128-64+yshift):(128+64+yshift),:]
    proj128 = np.flip(proj128_hold,1)
    #proj128 = proj128_hold

    return proj128

def read_orbit():
    Data_hold = np.loadtxt(file_system_head+'Projections/bgd256_run12_1.cor')
    Orbit_hold = Data_hold[:,0]*10
    return Orbit_hold

def add_noise(add_pos_noise,win_name,contrast,noise_scale):
    file_to_read = file_system_head+"Cases/DMSA128_"+win_name+"_Case"+str(Case_num)+'_'+str(round(contrast*10))+".prj"
    file_to_write_1 = file_system_head+"Cases/DMSA128_d1_"+win_name+"_Recon"+str(Recon_num)+"_Case"+str(Case_num)+'_'+str(round(contrast*10))+".nprj"
    file_to_write_2 = file_system_head+"Cases/DMSA128_d2_"+win_name+"_Recon"+str(Recon_num)+"_Case"+str(Case_num)+'_'+str(round(contrast*10))+".nprj"
    if add_pos_noise:
        rand_seed = 130000+rand.randint(1,1000)
        rand_seed = 135100
        print(noise_scale)
        print(type(noise_scale[0]))
        print(["../../C_Functions/add_noise2",file_to_read,file_to_write_1,"-sca",noise_scale[0],"-idum","-"+str(rand_seed)])
        subprocess.run(["../../C_Functions/add_noise2",file_to_read,file_to_write_1,"-sca",noise_scale[0],"-idum","-"+str(rand_seed)])
        rand_seed = 130000+rand.randint(1,1000)
        subprocess.run(["../../C_Functions/add_noise2",file_to_read,file_to_write_2,"-sca",noise_scale[0],"-idum","-"+str(rand_seed)])
    else:
        shutil.copyfile(file_to_read,file_to_write_1)
        shutil.copyfile(file_to_read,file_to_write_2)

def Do_Recon(win_name,contrast):
    Recon_input = ["../../C_Functions/os_p"]
    Recon_input.extend(["-emfl1",file_system_head+"Cases/DMSA128_d1_"+win_name+"_Recon"+str(Recon_num)+"_Case"+str(Case_num)+'_'+str(round(contrast*10))+".nprj"])
    Recon_input.extend(["-emfl2",file_system_head+"Cases/DMSA128_d2_"+win_name+"_Recon"+str(Recon_num)+"_Case"+str(Case_num)+'_'+str(round(contrast*10))+".nprj"])
    Recon_input.extend(["-boutfl",file_system_head+"Reconstructions/DMSA128_d1d2_"+win_name+"_Recon"+str(Recon_num)+"_Case"+str(Case_num)+'_'+str(round(contrast*10))])
    Recon_input.extend(["-p",str(128)])
    Recon_input.extend(["-iters",str(2)])
    Recon_input.extend(["-res_int",str(0.1614)])
    Recon_input.extend(["-hsize",str(0.04926)])
    Recon_input.extend(["-dle",str(0.01415)])
    Recon_input.extend(["-depth_int",str(number_of_projections)])
    Recon_input.extend(["-apx",str(0.23976)])
    Recon_input.extend(["-ror",str(27.0)])
    Recon_input.extend(["-rorfl1",file_system_head+"Cases/dmsa_orbit.txt"])
    Recon_input.extend(["-rorfl2",file_system_head+"Cases/dmsa_orbit.txt","-360"])
    Recon_input.extend(["-from",str(0),"to",str(127)])
    Recon_input.extend(["-o",str(0.479)])
    Recon_input.extend(["-ext","osp"])
    Recon_input.extend(["-bflg",str(0)])
    Recon_input.extend(["-G",str(8)])
    Recon_input.extend(["-gproj",str(240)])
    Recon_input.extend(["-heads",str(2)])
    Recon_input.extend(["-off_angle",str(0.0)])
    Recon_input.extend(["-verbose"])
    Recon_input.extend(["-circular_flg",str(1)])
    subprocess.run(Recon_input)



#percision = 256
Case_num = args.Case_number
pt_num = args.Patient_number
add_pos_noise = args.Add_Noise
contrast_in = args.Contrast/10;
Recon_num = args.Recon_number
#number_of_projections = 120
#file_list = ['bgd','spl','lrv','rkd','lkd','ls1','ls2','ls3']

# Tell the program where to find the directory structure for the patient
file_system_head = '../../../pt'+str(pt_num)+'/'

#Parse input file
Inputs = Parse_input(file_system_head,Case_num)
#print(Inputs['Percision'])
#print(type(Inputs['Percision']))
percision = Inputs['Percision']
file_list = Inputs['file_list']
number_of_projections = Inputs['Number_of_Projections']
scales = [float(x) for x in Inputs['scales']]
noise_scale_in = Inputs['noise_scale']
#print(add_pos_noise)
if(add_pos_noise is None):
    add_pos_noise = Inputs['add_noise']
#print(add_pos_noise)
# Generate the composit projections for the case
[Photopeak,Scatter] = add_projections(file_list,percision,120,scales,contrast_in)


Photopeak.astype('float32').tofile(file_system_head+'Cases/DMSA256_ppsc_Case'+str(Case_num)+'.prj')
Scatter.astype('float32').tofile(file_system_head+'Cases/DMSA256_sc_Case'+str(Case_num)+'.prj')

# Extract the 128 projection set from the 256 projection set and save it to the Reconstruction directory
DMSA128_ppsc = extract_projection(Photopeak,0,0)
DMSA128_ppsc_to_write = np.reshape(DMSA128_ppsc,(-1),order='F')
DMSA128_ppsc_to_write.astype('float32').tofile(file_system_head+"Cases/DMSA128_ppsc_Case"+str(Case_num)+'_'+str(round(contrast_in*10))+".prj")

DMSA128_sc = extract_projection(Scatter,0,0)
DMSA128_sc_to_write = np.reshape(DMSA128_sc,(-1),order='F')
DMSA128_sc_to_write.astype('float32').tofile(file_system_head+"Cases/DMSA128_sc_Case"+str(Case_num)+'_'+str(round(contrast_in*10))+".prj")

# Read out the orbit to be used in reconstruction and save it in the recon directory
Orbit = read_orbit()
np.savetxt(file_system_head+'Cases/dmsa_orbit.txt',Orbit,fmt='%.3f')

# Add the noise to the projection
add_noise(add_pos_noise,"ppsc",contrast_in,noise_scale_in)
add_noise(add_pos_noise,"sc",contrast_in,noise_scale_in)

# Do Reconstructions
Do_Recon("ppsc",contrast_in)
Do_Recon("sc",contrast_in)







