{ pkgs, ... }: {
  programs.helix = {
    enable = true;
    settings = {
      keys.normal = {
        m = "move_char_left";
        n = "move_line_down";
        e = "move_line_up";
        i = "move_char_right";

        u = "insert_mode";
        U = "insert_at_line_start";

        y = "open_below";
        Y = "open_above";

        j = "move_next_word_end";
        J = "move_next_long_word_end";

        k = "search_next";
        K = "search_prev";

        l = "undo";
        L = "redo";

        f = "move_next_word_end";
        F = "move_next_long_word_end";
        g = "find_till_char";
        t = "find_next_char";
        G = "till_prev_char";
        T = "find_prev_char";
        D = "goto_line";

        p = "replace";
        P = "replace_with_yanked";
        a = "append_mode";
        A = "insert_at_line_end";
        A-l = "earlier";
        A-L = "later";
        ";" = "paste_after";
        ":" = "paste_before";
        "=" = "format_selections";
        s = "delete_selection";
        r = "select_regex";
        R = "split_selection";
        A-r = "split_selection_on_newline";
        o = "collapse_selection";
        A-o = "flip_selections";
        A-O = "ensure_selections_forward";
        N = "join_selections";
        A-N = "join_selections_space";
        E = "keep_selections";
        A-E = "remove_selections";
        A-y = "expand_selection";
        A-u = "shrink_selection";
        "A-;" = "select_prev_sibling";
        "A-k" = "select_next_sibling";

        O = "command_mode";
      };

      # keys.normal.g = {
      #   n = "goto_line_start";
      #   o = "goto_line_end";
      # };


      keys.normal.space.w = {
        n = "jump_view_left";
        e = "jump_view_down";
        i = "jump_view_up";
        o = "jump_view_right";
      };

      keys.normal.C-w = {
        n = "jump_view_left";
        e = "jump_view_down";
        E = "join_selections";
        "A-E" = "join_selections_space";

        i = "jump_view_up";
        I = "keep_selections";
        "A-I" = "remove_selections";

        o = "jump_view_right";

      };

      keys.insert = {
        "A-x" = "normal_mode"; # Maps Alt-X to enter normal mode
      };


      keys.select = {
        n = "move_char_left";
        e = "move_line_down";
        i = "move_line_up";
        o = "move_char_right";

        h = "insert_mode";
        H = "insert_at_line_start";

        l = "open_below";
        L = "open_above";

        k = "move_next_word_end";
        K = "move_next_long_word_end";

        j = "search_next";
        J = "search_prev";
      };

      keys.normal.z = {
        i = "scroll_up";
        g = "align_view_top";
        t = "no_op";
        n = "scroll_down";
        j = "no_op";
        e = "scroll_up";
        k = "no_op";
        C-t = "page_down";
        C-f = "no_op";
        C-s = "half_page_down";
        C-d = "no_op";
        C-l = "half_page_up";
        C-u = "no_op";
      };

      keys.normal.Z = {
        i = "scroll_up";
        g = "align_view_top";
        t = "no_op";
        n = "scroll_down";
        j = "no_op";
        e = "scroll_up";
        k = "no_op";
        C-t = "page_down";
        C-f = "no_op";
        C-s = "half_page_down";
        C-d = "no_op";
        C-l = "half_page_up";
        C-u = "no_op";
      };

      keys.normal.d = {
        d = "goto_file_start";
        f = "goto_last_line";
        t = "goto_file";
        i = "goto_line_end";
        r = "goto_first_nonwhitespace";
        g = "goto_window_top";
        s = "goto_definition";
        j = "goto_type_definition";
        p = "goto_reference";
        u = "goto_implementation";
        k = "goto_next_buffer";
        ";" = "goto_previous_buffer";
        n = "move_line_down";
        e = "move_line_up";
      };

      # keys.normal.m = {
      # # m = "match_brackets" # the same
      # 	r = "surround_add";
      # 	p = "surround_replace";
      # 	s = "surround_delete";
      # 	d = "no_op";
      # 	u = "select_textobject_inner";
      # 	i = "no_op";
      # }; 
      theme = "base16_transparent";
      editor = {
        line-number = "relative";
        lsp.display-messages = true;
        cursor-shape = {
          insert = "bar";
          select = "underline";
          normal = "block";
        };
      };
    };
    languages = {
      language-server = {
        nixd = {
          command = "${pkgs.nixd}/bin/nixd";
        };
      };
      language = [
        {
          name = "nix";
          file-types = [ "nix" ];
          roots = [ "flake.nix" ];
          language-servers = [ "nixd" ];
          formatter = {
            command = "${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt";
          };
          auto-format = true;
        }
      ];
    };
  };
}
