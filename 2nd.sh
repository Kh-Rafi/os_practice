
declare -a p bt wt tat

printf "\n"
read -p " Enter the number of processes: " n
printf "\n"

for ((i=0; i<n; i++)); do
    p[$i]=$i
    read -p " Enter Burst Time for Process P$i: " bt[$i]
done

for ((i=0; i<n; i++)); do
    for ((k=i+1; k<n; k++)); do
        if (( bt[i] > bt[k] )); then
            temp=${bt[$i]}
            bt[$i]=${bt[$k]}
            bt[$k]=$temp

            temp=${p[$i]}
            p[$i]=${p[$k]}
            p[$k]=$temp
        fi
    done
done

wt[0]=0
wtavg=0
tat[0]=${bt[0]}
tatavg=${bt[0]}

for ((i=1; i<n; i++)); do
    wt[$i]=${tat[$((i-1))]}
    tat[$i]=$((wt[$i] + bt[$i]))
    wtavg=$((wtavg + wt[$i]))
    tatavg=$((tatavg + tat[$i]))
done

printf "\n\t PROCESS \tBURST TIME \t WAITING TIME\t TURNAROUND TIME\n"

for ((i=0; i<n; i++)); do
    printf "\n\t P%d \t\t %d \t\t %d \t\t %d" "${p[$i]}" "${bt[$i]}" "${wt[$i]}" "${tat[$i]}"
done

printf "\n\n"
avg_wt=$(awk "BEGIN {printf \"%.6f\", $wtavg / $n}")
avg_tat=$(awk "BEGIN {printf \"%.6f\", $tatavg / $n}")

printf "Average Waiting Time --> %s \n\n" "$avg_wt"
printf "Average Turnaround Time --> %s \n\n" "$avg_tat"
