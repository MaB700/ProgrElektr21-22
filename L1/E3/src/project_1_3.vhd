----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/14/2022 01:55:10 PM
-- Design Name: 
-- Module Name: project_1_3 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity project_1_3 is
  Port ( 
    sw : in std_logic_vector (15 downto 0);
    led: out std_logic_vector (1 downto 0)
    -- P_ODD : out std_logic
  );
end project_1_3;

architecture Behavioral of project_1_3 is
    
begin
    -- led(1) odd
    -- led(0) even
    led(1) <= (sw(0) xor sw(1)) xor sw(2) xor sw(3) xor sw(4) xor sw(5) xor sw(6) xor sw(7) xor sw(8) xor sw(9) xor sw(10) xor sw(11) xor sw(12) xor sw(13) xor sw(14) xor sw(15);
    led(0) <= not (sw(0) xor sw(1) xor sw(2) xor sw(3) xor sw(4) xor sw(5) xor sw(6) xor sw(7) xor sw(8) xor sw(9) xor sw(10) xor sw(11) xor sw(12) xor sw(13) xor sw(14) xor sw(15));


end Behavioral;

--entity xor_2 is
--    port (
--        I2: in  std_logic_vector (1 downto 0);
--        O2: out std_logic
--    );
--end entity xor_2;

--architecture behaviour of xor_2 is
--begin
--    O2 <= I2(0) xor I2(1);
--end architecture behaviour;

--entity xor_4 is
--    port (
--        I3: in std_logic_vector (3 downto 0);
--        O3: out std_logic
--    );
--end entity xor_4;

--architecture beh_xor4 of xor_4 is
--    signal wire_0_xor_1, wire_2_xor_3 : std_logic;
--begin
--    xor_2_a : entity xor_2
--    port map (
--        I3(0) => I2(0),
--        I3(1) => I2(1),
--        O3   => wire_0_xor_1
--        );
--    xor_2b : entity xor_2
--    port map (
--        I3(0) => I2(2),
--        I3(1) => I2(3),
--        O3    => wire_2_xor_3
--    )
--    xor_2c : entity xor_2
--    port map (
--        I3(0) => wire_0_xor_1,
--        I3(1) => wire_1_xor_2,
--        O3    => O3
--    )
--end architecture beh_xor4;