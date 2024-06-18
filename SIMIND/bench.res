


              SIMIND Monte Carlo Simulation Program    V7.0  
------------------------------------------------------------------------------
 Phantom(S): h2o       Crystal...: nai       InputFile.: bench             
 Phantom(B): bone      BackScatt.: pmt       OutputFile: bench             
 Collimator: pb_sb2    SourceRout: none      SourceFile: none              
 Cover.....: al        ScoreRout.: none      DensityMap: none              
------------------------------------------------------------------------------
 PhotonEnergy.......: 140          Spectra  PhotonsPerProj....: 10000000       
 EnergyResolution...: 8.8          ge-legp  Activity..........: 1              
 MaxScatterOrder....: 3            BScatt   DetectorLenght....: 25             
 DetectorWidth......: 0            Phantom  DetectorHeight....: 0.953          
 UpperEneWindowTresh: 154          Resolut  Distance to det...: 25             
 LowerEneWindowTresh: 126          IntFile  ShiftSource X.....: 0              
 PixelSize  I.......: 0.44                  ShiftSource Y.....: 0              
 PixelSize  J.......: 0.44                  ShiftSource Z.....: 0              
 HalfLength S.......: 0                     HalfLength P......: 8.32           
 HalfWidth  S.......: 0                     HalfWidth  P......: 11             
 HalfHeight S.......: 0                     HalfHeight P......: 11             
 SourceType.........: PointSrc              PhantomType.......: HorCylinder  
------------------------------------------------------------------------------
 GENERAL DATA
 keV/channel........: 0.5                   CutoffEnergy......: 0              
 Photons/Bq.........: 0.879                 StartingAngle.....: 0              
 CameraOffset X.....: 0                     CoverThickness....: 0              
 CameraOffset Y.....: 0                     BackscatterThickn.: 10             
 MatrixSize I.......: 64                    IntrinsicResolut..: 0.34           
 MatrixSize J.......: 64                    AcceptanceAngle...: 4.02754        
 Emission type......: 2                     Initial Weight....: 0.0879         
 NN ScalingFactor...: 1                     Energy Channels...: 512            
------------------------------------------------------------------------------
 COLLIMATOR DATA FOR ROUTINE: Analytical          
 CollimatorCode.....: ge-legp               CollimatorType....: Parallel 
 HoleSize X.........: 0.25                  Distance X........: 0.03           
 HoleSize Y.........: 0.28868               Distance Y........: 0.17032        
 CenterShift X......: 0.14                  X-Ray flag........: F              
 CenterShift Y......: 0.24249               CollimThickness...: 4.1            
 HoleShape..........: Hexagonal             Space Coll2Det....: 0              
 CollDepValue [57]..: 0                     CollDepValue [58].: 0              
 CollDepValue [59]..: 0                     CollDepValue [60].: 0              
 Header file........: bench.res                               
 Image file.........: bench.bim                               
------------------------------------------------------------------------------
 INTERACTIONS IN THE CRYSTAL
 MaxValue spectrum..: 1.494          
 MaxValue projection: 1.685          
 CountRate spectrum.: 108.7          
 CountRate E-Window.: 47.59          
------------------------------------------------------------------------------
 PHOTONS AFTER COLLIMATOR AND WITHIN ENER-WIN
 Geometric..........:   0.00 %         100.00 %
 Penetration........:   0.00 %           0.00 %
 Scatter in collim..:   0.00 %           0.00 %
 X-rays in collim...:   0.00 %           0.00 %
------------------------------------------------------------------------------
 SCATTER IN ENERGY WINDOW
 Scatter/Primary....: 0.64698         0.35 % (1SD)
 Scatter/Total......: 0.39283        
 Scatter order 1....: 82.85 %        
 Scatter order 2....: 15.48 %        
 Scatter order 3....: 1.67 %         
------------------------------------------------------------------------------
 CALCULATED DETECTOR PARAMETERS
 Efficiency E-Window: 0.4229          0.14 % (1SD)
 Efficiency spectrum: 0.9658         
 Sensitivity Cps/MBq: 47.5931        
 Sensitivity Cpm/uCi: 105.6567       
------------------------------------------------------------------------------
 Simulation started.: 2022:04:14 13:14:31
 Simulation stopped.: 2022:04:14 13:14:53
 Elapsed time.......: 0 h, 0 m and 22 s
 DetectorHits.......: 36219177       
 DetectorHits/CPUsec: 1603363        
------------------------------------------------------------------------------
 SIMIND built 2021:08:28 with INTEL Linux  compiler
 Random number generator: Intel RAN
 Comment:STATIC
 Energy resolution as function of 1/sqrt(E)
 Inifile: simind.ini
 Command: bench.smc
