declare -i num_cores=$(cat /proc/cpuinfo | grep processor | wc -l) # get the number of cores

for ((i=0; i<num_cores; i++)); do
    sudo cpufreq-set -c $i -g performance
done

# check governors using:
# cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
