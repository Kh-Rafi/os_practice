read -p "Enter the number of processes: " n
echo ""
 
declare -a pid bt pr wt tat
 

for ((i=0; i<n; i++)); do
    pid[$i]=$i
    read -p "Enter Burst Time & Priority for Process P$i: " bt[$i] pr[$i]
done
 

for ((i=0; i<n-1; i++)); do
    for ((j=0; j<n-i-1; j++)); do
        if [ ${pr[$j]} -gt ${pr[$((j+1))]} ]; then
            # Swap Priority
            temp_pr=${pr[$j]}
            pr[$j]=${pr[$((j+1))]}
            pr[$((j+1))]=$temp_pr

            temp_bt=${bt[$j]}
            bt[$j]=${bt[$((j+1))]}
            bt[$((j+1))]=$temp_bt
 

            temp_pid=${pid[$j]}
            pid[$j]=${pid[$((j+1))]}
            pid[$((j+1))]=$temp_pid
        fi
    done
done
 

wt[0]=0
tat[0]=${bt[0]}
total_wt=0
total_tat=${tat[0]}
 
for ((i=1; i<n; i++)); do
    wt[$i]=$((wt[$((i-1))] + bt[$((i-1))]))
    tat[$i]=$((wt[$i] + bt[$i]))
    total_wt=$((total_wt + wt[$i]))
    total_tat=$((total_tat + tat[$i]))
done
 

echo ""
printf "\t%-15s %-15s %-15s %-18s %-18s\n" "PROCESS" "PRIORITY" "BURST TIME" "WAITING TIME" "TURNAROUND TIME"
echo ""
 
for ((i=0; i<n; i++)); do
    printf "\tP%-14s %-15s %-15s %-18s %-18s\n" "${pid[$i]}" "${pr[$i]}" "${bt[$i]}" "${wt[$i]}" "${tat[$i]}"
done
echo ""

avg_wt=$(awk "BEGIN {printf \"%.6f\", $total_wt / $n}")
avg_tat=$(awk "BEGIN {printf \"%.6f\", $total_tat / $n}")
 
echo "Average Waiting Time --> $avg_wt"
echo ""
echo "Average Turnaround Time --> $avg_tat"