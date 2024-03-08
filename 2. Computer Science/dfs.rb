class Hash
  def dfs(skey)
    puts self
    return self.slice(skey) if key?(skey)

    keys.each do |key|
      if self[key].is_a?(Hash)
        result = self[key].dfs(skey)
        return result if result 
      end
    end
    nil
  end
end

test = { a: {
  b: { c: 1, d: 2},
  e: { ea: 1, eb: 2}
}
}

binding.irb