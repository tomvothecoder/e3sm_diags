#!/bin/bash
# Script initiated by Jerry Potter and modified by Jill Zhang (zhang40@llnl.gov)

path='/p/user_pub/e3sm/zhang40/analysis_data_e3sm_diags/ISLSCPII_GRDC/'

time_series_output_path=$path'time_series/'
climo_output_path=$path'climatology/'
tmp=$path'tmp/'

mkdir $climo_output_path
mkdir $tmp

cd $time_series_output_path
echo $path

cdo splityear QRUNOFF_198601_199512.nc ${tmp}QRUNOFF

for yr in {1986..1995}; do
    yyyy=`printf "%04d" $yr`

    for mth in {1..12}; do
        mm=`printf "%02d" $mth`
        ncks -O -F -d time,${mth} ${tmp}QRUNOFF${yyyy}.nc ${tmp}QRUNOFF_${yyyy}${mm}.nc
        done
done



cd ${tmp}
ncclimo -a sdd --lnk_flg -c QRUNOFF_198601.nc -s 1986 -e 1995
mv *climo.nc $climo_output_path


#ncclimo -a sdd --lnk_flg -c HadISST_PI_187001.nc -s 1999 -e 2016
#ncclimo -a sdd --lnk_flg -c HadISST_PI_187001.nc -s 1870 -e 1900
#rm 'HadiSST'${yyyy}'.nc'
#for yr in {1870..2016}; do
#    yyyy=`printf "%04d" $yr`
#    cdo setrtomiss,-1e20,-1000 'HadiSSTi'${yyyy}'.nc' 'HadiSSTii'${yyyy}'.nc'
#    rm 'HadiSSTi'${yyyy}'.nc'
#    mv 'HadiSSTii'${yyyy}'.nc' 'HadiSST'${yyyy}'.nc'
#done




