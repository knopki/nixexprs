self: super: {
  waybar = super.waybar.override {
    pulseSupport = true;
  };
}
