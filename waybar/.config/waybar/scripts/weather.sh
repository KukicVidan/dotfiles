
#!/bin/bash

source ~/.config/waybar/scripts/.env

declare wc=(
  "☀️"  # 0
  "⛅"  # 1–3
  "☁️"  # 45, 48
  "🌧️"  # 51–67, 80–82
  "⛈️"  # 95–99
  "❄️"  # 71–77, 85–86
)

declare -A WEATHER_CODES=(
  ["0"]="${wc[0]}"
  ["1"]="${wc[1]}"
  ["2"]="${wc[1]}"
  ["3"]="${wc[1]}"
  ["45"]="${wc[2]}"
  ["48"]="${wc[2]}"
  ["51"]="${wc[3]}"
  ["53"]="${wc[3]}"
  ["55"]="${wc[3]}"
  ["61"]="${wc[3]}"
  ["63"]="${wc[3]}"
  ["65"]="${wc[3]}"
  ["66"]="${wc[3]}"
  ["67"]="${wc[3]}"
  ["71"]="${wc[5]}"
  ["73"]="${wc[5]}"
  ["75"]="${wc[5]}"
  ["77"]="${wc[5]}"
  ["80"]="${wc[3]}"
  ["81"]="${wc[3]}"
  ["82"]="${wc[3]}"
  ["85"]="${wc[5]}"
  ["86"]="${wc[5]}"
  ["95"]="${wc[4]}"
  ["96"]="${wc[4]}"
  ["99"]="${wc[4]}"
)

weather=$(curl -s "https://api.open-meteo.com/v1/forecast?latitude=${LATITUDE}&longitude=${LONGITUDE}&current=temperature_2m,apparent_temperature,weather_code,wind_speed_10m&timezone=auto")

weather_code=$(echo "$weather" | jq -r '.current.weather_code')
feels_like=$(echo "$weather" | jq -r '.current.apparent_temperature')
wind_speed=$(echo "$weather" | jq -r '.current.wind_speed_10m')

if [ -z "$weather_code" ] || [ "$weather_code" = "null" ]; then
  echo "⛅"
else
  tempint=$(echo "$feels_like" | cut -d. -f1)
  extrachar=''
  if [[ $tempint -gt 0 && $tempint -lt 10 ]]; then
    extrachar='+'
  fi

  text=$(printf "%s %s%s°C 🍃 %.1fkm/h" "${WEATHER_CODES[$weather_code]}" "$extrachar" "$feels_like" "$wind_speed")
  echo "${text}"
fi
