describe "Any queries" do
  include_context "db"

  context "German name" do
    it "includes German name" do
      assert_search_equal %Q[foreign:"Abrupter Verfall"], %Q[de:"Abrupter Verfall"]
      assert_search_equal %q[foreign:/\bvon der\b/], %q[de:/\bvon der\b/]
    end

    it "is anywhere match with de:" do
      assert_search_equal %Q[de:"Spinner"], %Q[de:/Spinner/]
    end

    it "is word match with foreign:" do
      assert_search_equal %Q[foreign:"Spinner"], %Q[foreign:/\bSpinner\b/ or (Arachnus Spinner)]
    end
  end

  context "French name" do
    it do
      assert_search_equal %Q[foreign:"Décomposition abrupte"], %Q[fr:"Décomposition abrupte"]
    end
    it "is case insensitive" do
      assert_search_equal %Q[foreign:"Décomposition abrupte"], %Q[foreign:"décomposition ABRUPTE"]
    end
    it "ignores diacritics" do
      assert_search_equal %Q[foreign:"Décomposition abrupte"], %Q[foreign:"Decomposition abrupte"]
    end
  end

  it "includes Italian name" do
    assert_search_equal %Q[foreign:"Deterioramento Improvviso"], %Q[it:"Deterioramento Improvviso"]
  end

  it "includes Japanese name" do
    assert_search_equal %Q[foreign:"血染めの月"], %Q[jp:"血染めの月"]
  end

  it "includes Russian name" do
    assert_search_equal %Q[foreign:"Кровавая луна"], %Q[ru:"Кровавая луна"]
  end

  it "includes Spanish name" do
    assert_search_equal %Q[foreign:"Puente engañoso"], %Q[sp:"Puente engañoso"]
  end

  it "includes Portuguese name" do
    assert_search_equal %Q[foreign:"Ponte Traiçoeira"], %Q[pt:"Ponte Traiçoeira"]
  end

  it "includes Korean name" do
    assert_search_equal %Q[foreign:"축복받은 신령들"], %Q[kr:"축복받은 신령들"]
    assert_search_equal %q[foreign:/축복받은/], %q[kr:/축복받은/]
  end

  it "includes Chinese Traditional name" do
    assert_search_equal %Q[foreign:"刻拉諾斯的電擊"], %Q[ct:"刻拉諾斯的電擊"]
  end

  it "includes Chinese Simplified name" do
    assert_search_equal %Q[foreign:"刻拉诺斯的电击"], %Q[cs:"刻拉诺斯的电击"]
  end

  it "wildcard" do
    # Searching cards, as languages are not attached to printings
    assert_search_equal_cards "t:planeswalker -ru:* de:*", "t:planeswalker e:c14,c18,cmr"
  end

  it "only matches full words (except CJK and German)" do
    assert_search_differ %q[foreign:/red/], %q[foreign:/\bred\b/]
    assert_search_differ %q[foreign:/电击/], %q[foreign:/\b电击\b/]
    assert_search_equal %q[foreign:red], %q[foreign:/\bred\b/]
    assert_search_equal %q[foreign:电击], %q[foreign:/电击/]
  end

  # It looks like scryfall went for in:* so for compatibility
  it "in:X aliases X:*" do
    assert_search_equal "in:cs", "cs: *"
    assert_search_equal "in:ct", "ct: *"
    assert_search_equal "in:de", "de: *"
    assert_search_equal "in:fr", "fr: *"
    assert_search_equal "in:it", "it: *"
    assert_search_equal "in:jp", "jp: *"
    assert_search_equal "in:kr", "kr: *"
    assert_search_equal "in:pt", "pt: *"
    assert_search_equal "in:ru", "ru: *"
    assert_search_equal "in:sp", "sp: *"
    assert_search_equal "in:cn", "cn: *"
    assert_search_equal "in:tw", "tw: *"
  end
end
