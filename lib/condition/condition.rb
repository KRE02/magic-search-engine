class Condition
  def include_extras?
    false
  end

  def inspect
    to_s
  end

  # For simple conditions
  # cond.search(db) == db.select{|card| cond.match?(card)}
  # This is extremely relevant for query optimization
  def simple?
    false
  end

  # Save only what's needed, by default nothing
  def metadata=(options)
  end

  private

  def normalize_text(text)
    text.downcase.gsub(/[Ææ]/, "ae").tr("Äàáâäèéêíõöúûü’\u2212", "Aaaaaeeeioouuu'-").strip
  end

  def normalize_name(name)
    normalize_text(name).split.join(" ")
  end

  def maybe_quote(text)
    if text =~ /\A[a-zA-Z0-9]+\z/
      text
    else
      text.inspect
    end
  end
end
