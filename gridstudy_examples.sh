#!/bin/bash



N=20
if [ -d "res_N20" ]; then rm -r res_N${N}; fi
if [ ! -f times.txt ]; then 
    touch times.txt
else 
    echo "" >> times.txt
    echo "--- new run ---" >> times.txt
fi


for p in 10 50 250 1500 6000; do
    echo "N: ${N}, P: ${p}, Time: $(date)" 
    echo "N: ${N}, P: ${p}, Time: $(date)" >> times.txt
    make clean
    make
    mpirun -use-hwthread-cpus ./bifurcation3d 20 ${p}
    mv res_N${N} res_N${N}_P${p}
    mkdir res_N${N}_P${p}/animations
done



# ---- Parameters ----

# const T Re = 14;                    // Reynolds number (50)

# int N = 20;                         // resolution of the model (19)
# const T radius = 1e-4;              // particles radius (1.5e-3)
# const T partRho = 1e3;              // particles density (998.2)

# std::size_t noOfParticles = 10;   // total number of inserted particles (1000)

# const T fluidMaxPhysT = T( 10 );     // max. fluid simulation time in s, SI unit (5)
# const T particleMaxPhysT = T( 20 ); // max. particle simulation time in s, SI unit (20)

# //Set capture method:
# // materialCapture: based on material number
# // wallCapture:     based on more accurate stl description
# typedef enum {materialCapture, wallCapture, velocityWallReflection} ParticleDynamicsSetup;
# // const ParticleDynamicsSetup particleDynamicsSetup = wallCapture;
# const ParticleDynamicsSetup particleDynamicsSetup = velocityWallReflection;// reflection instead of capture
