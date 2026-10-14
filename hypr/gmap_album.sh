source ~/.colors.sh

cat > /tmp/gradient.svg <<EOF
<svg width="256" height="1" xmlns="http://www.w3.org/2000/svg">
<defs>
  <linearGradient id="g">
    <stop offset="0%"   stop-color="$background"/>
    <stop offset="33.33%" stop-color="$color4"/>
    <stop offset="66.66%" stop-color="$color6"/>
    <stop offset="100%" stop-color="$foreground"/>
  </linearGradient>
</defs>
<rect width="256" height="1" fill="url(#g)"/>
</svg>
EOF

magick /tmp/spot_cover.png \
  -colorspace gray \
  /tmp/gradient.svg \
  -channel RGB -clut +channel \
  /tmp/spot_cover_mapped.png
