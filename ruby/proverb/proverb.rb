class Proverb

  def initialize(*args, **opts)
    @nouns = args
    opts ||= {}
    @proverb_lines = generate_lines(opts[:qualifier] || '')
  end

  def to_s
    @proverb_lines.join("\n")
  end

  private

  def generate_lines(qualifier='')
    qualifier += ' ' unless qualifier.empty?
    lines = @nouns.each_cons(2).map { |want, thing| make_sentence(want, thing) }
    lines.push "And all for the want of a #{qualifier}#{@nouns.first}."
  end

  def make_sentence(want, thing)
    "For want of a #{want} the #{thing} was lost."
  end

end
