function importgui()
    win = get("importgui");
    if ~isempty(win) then
        //set visible
        set("win", "visible", "on");
        //set on top
        set("win");
        return;
    end
    
    w = 800;
    h = 600;
    
	fig = figure(...
		"figure_name", _("Import data"), ...
		"dockable", "off", ...
		"axes_size", [w h], ...
		"infobar_visible", "off", ...
		"toolbar_visible", "off", ...
		"menubar_visible", "off", ...
		"default_axes", "off", ...
		"background", -2, ...
		"resize", "off", ...
        "layout", "border", ...
		"tag", "importgui", ...
		"visible", "off");

    //Border frame
    t = uicontrol(fig, ...
        "style", "frame", ...
        "constraints", createConstraints("border", "top", [0 90]));
        
    c = uicontrol(fig, ...
        "style", "frame", ...
        "layout", "border", ...
        "constraints", createConstraints("border", "center"));
    
    uicontrol(c, ...
        "style", "frame", ...
        "tag", "importgui_preview", ...
        "scrollable", "on", ...
        "layout", "gridbag", ...
        "constraints", createConstraints("border", "center"));
        
    b = uicontrol(fig, ...
        "style", "frame", ...
        "constraints", createConstraints("border", "bottom", [0 45]));

    //frame file
    fr1 = uicontrol(t, ...
        "style", "frame", ...
        "position", [0 0 800 90]);

    uicontrol(fr1, ...
        "style", "text", ...
        "position", [20 50 560 30], ...
        "horizontalalignment", "center", ...
        "relief", "solid", ...
        "fontsize", 13, ...
        "fontweight", "bold", ...
        "tag", "importgui_filename")
        
    uicontrol(fr1, ...
        "style", "pushbutton", ...
        "string", _("Select a file"), ...
        "callback", "importgui_cbselect", ...
        "position", [600 50 180 30]);

    uicontrol(fr1, ...
        "style", "checkbox", ...
        "string", _("File has a header"), ...
        "tag", "importgui_header", ...
        "callback", "importgui_preview", ...
        "position", [20 20 130 25]);

    uicontrol(fr1, ...
        "style", "checkbox", ...
        "string", _("Show all columns"), ...
        "tooltip", _("It can take a long time"), ...
        "tag", "importgui_showcol", ...
        "callback", "importgui_preview", ...
        "position", [20 0 130 25]);

    uicontrol(fr1, ...
        "style", "text", ...
        "string", _("Separator"), ...
        "horizontalalignment", "center", ...
        "position", [180 10 60 25]);

        uicontrol(fr1, ...
        "style", "popupmenu", ...
        "string", [_("Comma"), _("Space"), _("Tab"), _("Semicolon"), _("Pipe"), _("Colon")], ...
        "userdata", [",", " ", ascii(9), ";", "|", ":"], ...
        "value", 4, ...
        "tag", "importgui_delim", ...
        "callback", "importgui_preview", ...
        "position", [240 10 120 25]);

    uicontrol(fr1, ...
        "style", "text", ...
        "string", _("Decimal"), ...
        "horizontalalignment", "center", ...
        "position", [390 10 60 25]);

    uicontrol(fr1, ...
        "style", "popupmenu", ...
        "string", [_("Point"), _("Comma")], ...
        "userdata", [".", ","], ...
        "value", 1, ...
        "tag", "importgui_decimal", ...
        "callback", "importgui_preview", ...
        "position", [450 10 120 25]);

    uicontrol(fr1, ...
        "style", "text", ...
        "string", _("Conversion"), ...
        "horizontalalignment", "center", ...
        "position", [600 10 60 25]);

    uicontrol(fr1, ...
        "style", "popupmenu", ...
        "string", [_("Keep as strings"), _("Convert to double")], ...
        "userdata", ["string", "double"], ...
        "value", 1, ...
        "tag", "importgui_conversion", ...
        "callback", "importgui_preview", ...
        "position", [660 10 120 25]);

        
    //footer
    outer = uicontrol(b, ...
        "style", "frame", ...
        "position", [0 40 800 5], ...
        "border", createBorder("line", "#dddddd"));
        
    uicontrol(outer, ...
        "style", "frame", ...
        "backgroundcolor", [0 120 215]./255, ...
        "tag", "importgui_progressbar", ...
        "position", [0 0 0 5]);
    
    uicontrol(b, ...
        "style", "pushbutton", ...
        "string", _("Import as variable"), ...
        "callback", "importgui_variable", ...
        "enable", "off", ...
        "tag", "importgui_btnvarialble", ...
        "position", [50 5 200 30]);
        
    uicontrol(b, ...
        "style", "pushbutton", ...
        "string", _("Quit"), ...
        "callback", "delete(get(""importgui""));", ...
        "position", [300 5 200 30]);
        
    uicontrol(b, ...
        "style", "pushbutton", ...
        "string", _("Copy function to clipboard"), ...
        "callback", "importgui_function", ...
        "enable", "off", ...
        "tag", "importgui_btnfunction", ...
        "position", [550 5 200 30]);
        
    sw = getsystemmetrics("SM_CXSCREEN");
    sh = getsystemmetrics("SM_CYSCREEN");

    s = fig.figure_size;
    w = (sw - s(1)) / 2
    h = (sh - s(2)) / 2
    fig.figure_position = [w h];

    fig.visible = "on";
    importgui_cbselect();
endfunction
