checks_run(){
for c in uname hostname awk sed grep ps df du ls sort head tail date; do
need_cmd "$c"
done
pm_detect >/dev/null
service_detect >/dev/null
}