defmodule Username do

  @valid_chars 'zyxwvutsrqponmlkjihgfedcba_'

  def sanitize(username, sanitized \\ '')

  def sanitize('', sanitized), do: sanitized

  def sanitize([l|chrs], sanitized) do
    sanitize(chrs, sanitized ++ case l do
        ?ä -> 'ae'
        ?ö -> 'oe'
        ?ü -> 'ue'
        ?ß -> 'ss'
        l when l in @valid_chars -> [l]
        _ -> ''
      end
    )
  end
end
