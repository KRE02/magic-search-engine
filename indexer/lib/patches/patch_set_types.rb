class PatchSetTypes < Patch
  def call
    each_set do |set|
      set_code = set["code"]
      main_set_type = set.delete("type").gsub("_", " ")
      set_types = [main_set_type]

      case set_code
      when "bbd"
        set_types << "two-headed giant" << "multiplayer"
      when "mh1"
        set_types << "modern"
      when "cns", "cn2"
        set_types << "conspiracy" << "multiplayer"
      when "cp1", "cp2", "cp3"
        set_types << "deck"
      when "por", "p02", "ptk"
        set_types << "portal" << "booster"
      when "s99"
        set_types << "booster"
      when "s00", "w16", "itp", "cm1"
        set_types << "fixed"
      when "ugl", "unh", "ust"
        set_types << "un"
      when "tpr"
        set_types << "masters"
      when "ocmd", /\Aoc\d\d\z/
        set_types << "commander" << "multiplayer"
      when "pwpn", /\Apwp\d+\z/
        set_types << "wpn"
      when "parl", /\Apal\d+\z/
        set_types << "arena league"
      when "jgp", /\A[gj]\d\d\z/
        set_types << "judge gift"
      when "pdtp", /\Apdp\d\d\z/
        set_types << "duels"
      when /\Apmps\d\d\z/
        set_types << "premiere shop"
      when "mpr", /\Ap0[3-9]\z/, /\Ap[1-9]\d\z/
        set_types << "player rewards"
      when "pgtw", /\Apg\d\d\z/
        set_types << "gateway"
      when "fnm", /\Af\d\d\z/, "pdom", "pgrn", "pm19", "prna", "pwar"
        set_types << "fnm"
      end

      if set["name"] =~ /Welcome Deck/
        set_types << "standard"
      end

      case main_set_type
      when "core", "expansion"
        set_types << "standard"
      end

      case main_set_type
      when "archenemy", "commander", "conspiracy", "planechase", "vanguard", "multiplayer", "two-headed giant"
        set_types << "multiplayer"
      end

      case main_set_type
      when "from the vault", "vanguard"
        set_types << "fixed"
      end

      # st:booster is based on having boosters not on inference
      # (included in other boosters too?)
      if set["has_boosters"] or set["in_other_boosters"]
        set_types << "booster"
      end

      case main_set_type
      when "archenemy", "duel deck", "premium deck", "planechase", "box", "deck"
        set_types << "deck"
      when "commander"
        set_types << "deck" unless set_code == "cm1"
      end

      set["types"] = set_types.sort
    end
  end
end
