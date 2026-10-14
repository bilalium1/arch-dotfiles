source ~/.colors.sh

input=$(find ~/.config/hypr/misc/ -type f -name '*.png' | shuf -n 1)

cat > /tmp/gradient.svg <<EOF
<svg width="256" height="1" xmlns="http://www.w3.org/2000/svg">
<defs>
  <linearGradient id="g">
    <stop offset="20%" stop-color="$background"/>
    <stop offset="40%" stop-color="$color1"/>
    <stop offset="70%" stop-color="$color3"/>
    <stop offset="100%" stop-color="$foreground"/>
  </linearGradient>
</defs>
<rect width="256" height="1" fill="url(#g)"/>
</svg>
EOF

magick "$input" \
  -colorspace gray \
  /tmp/gradient.svg \
  -channel RGB -clut +channel \
  ~/.config/hypr/rose-mapped.png
