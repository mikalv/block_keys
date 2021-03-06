defmodule MnemonicTest do
  use ExUnit.Case, async: true

  alias BlockKeys.Mnemonic

  describe "entropy_from_phrase/1" do
    test "it generates entropy given a 24 word mnemonic with correct checksum" do
      mnemonic =
        "safe result wire cattle sauce luggage couple legend pause rather employ pear trigger live daring unlock music lyrics smoke mistake endorse kite obey siren"

      entropy = Mnemonic.entropy_from_phrase(mnemonic)

      assert byte_size(entropy) == 32
    end

    test "it returns an error if checksum is not correct" do
      mnemonic =
        "safe result wire cattle sauce luggage couple legend pause rather employ pear trigger live daring unlock music lyrics smoke mistake endorse kite obey able"

      assert {:error, "Checksum is not valid"} = Mnemonic.entropy_from_phrase(mnemonic)
    end
  end

  describe "generate_seed/2" do
    test "it generates seed given a 24 word mnemonic with correct checksum" do
      mnemonic =
        "safe result wire cattle sauce luggage couple legend pause rather employ pear trigger live daring unlock music lyrics smoke mistake endorse kite obey siren"

      seed = Mnemonic.generate_seed(mnemonic)

      assert seed ==
               "e8006d573be37f252c41d00dcd98a25abbd8ae3a1bdf500922faa6b29777b8a706997cb246587028687fe1fcc001da461f8c0eaa12d04219c1b1b9ad2fc808f1"
    end

    test "it returns an error given a 24 word mnemonic with incorrect checksum" do
      mnemonic =
        "safe result wire cattle sauce luggage couple legend pause rather employ pear trigger live daring unlock music lyrics smoke mistake endorse kite obey able"

      assert {:error, "Checksum is not valid"} = Mnemonic.generate_seed(mnemonic)
    end
  end
end
