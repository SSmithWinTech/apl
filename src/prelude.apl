⍬←0⍴0
⍝ ⍬     <=> 0⍴0
⍝ ⍴⍬    <=> ,0
⍝# ⍬←5   !!!
⍝ ⍳0    <=> ⍬
⍝ ⍴0    <=> ⍬
⍝ ⍬     <=> ⍬
⍝ ⍬⍬    <=> ⍬ ⍬
⍝ 1⍬2⍬3 <=> 1 ⍬ 2 ⍬ 3

~←~⍠{(~⍺∊⍵)/⍺}
⍝ "ABCDEFGHIJKLMNOPQRSTUVWXYZ"~"AEIOU" <=> 'BCDFGHJKLMNPQRSTVWXYZ'
⍝ 1 2 3 4 5 6~2 4 6                    <=> 1 3 5
⍝ "THIS IS TEXT"~" "                   <=> 'THISISTEXT'
⍝ "THIS" "AND" "THAT"~"T"              <=> 'THIS' 'AND' 'THAT'
⍝ "THIS" "AND" "THAT"~"AND"            <=> 'THIS' 'AND' 'THAT'
⍝ "THIS" "AND" "THAT"~⊂"AND"           <=> 'THIS' 'THAT'
⍝ "THIS" "AND" "THAT"~"TH" "AND"       <=> 'THIS' 'THAT'
⍝ 11 12 13 14 15 16~2 3⍴1 2 3 14 5 6   <=> 11 12 13 15 16
⍝ (2 2⍴⍳4)~2 !!! RANK ERROR

_hook←{⍵⍶⍹⍵;⍺⍶⍹⍵}
⍝ (+÷)\3 7 16 ¯294 <=> (3 3.142857142857143 3.1415929203539825 3.141592653921421)
⍝ (=⌊)123 <=> 1
⍝ (=⌊)123.4 <=> 0
⍝ (÷⍟)1000 <=> 144.76482730108395

⊃←{
  0=⍴⍴⍵:↑⍵
  0=×/⍴⍵:⍵
  shape←⍴⍵ ⋄ ⍵←,⍵
  r←⌈/≢¨shapes←⍴¨⍵ ⍝ maximum rank of all shapes
  max←↑⌈/shapes←(⍴ ↓ (r⍴1)∘,)¨shapes ⍝ maximum shape of rank adjusted shapes
  (shape,max)⍴↑⍪/shapes{max↑⍺⍴⍵}¨⍵
  ;
  1<⍴⍴⍺:↗'RANK ERROR'
  x←⍵
  {
    1<⍴⍴⍵:↗'RANK ERROR'
    ⍵←,⍵
    (⍴⍵)≠⍴⍴x:↗'RANK ERROR'
    ∨/⍵≥⍴x:↗'INDEX ERROR'
    x←⊃⍵⌷x
  }¨⍺
  x
}
⍝ ⊃3            <=> 3
⍝ ⊃(1 2)(3 4)   <=> 2 2⍴1 2 3 4
⍝ ⊃(1 2)(3 4 5) <=> 2 3⍴1 2 0 3 4 5
⍝ ⊃1 2          <=> 1 2
⍝ ⊃(1 2)3       <=> 2 2⍴1 2 3 0
⍝ ⊃1(2 3)       <=> 2 2⍴1 0 2 3
⍝ ⊃2 2⍴1(1 1 2⍴3 4)(5 6)(2 0⍴0) <=> 2 2 1 2 2⍴1 0 0 0 3 4 0 0 5 6 0 0 0 0 0 0
⍝ ⊃⍬            <=> ⍬
⍝ ⊃2 3 0⍴0      <=> 2 3 0⍴0
⍝ ⍬⊃3               <=> 3
⍝ 2⊃'PICK'          <=> 'C'
⍝ (⊂1 0)⊃2 2⍴'ABCD' <=> 'C'
⍝ 1⊃'foo' 'bar'     <=> 'bar'
⍝ 1 2⊃'foo' 'bar'   <=> 'r'
⍝ (2 2⍴0)⊃1 2       !!! RANK ERROR
⍝ (⊂2 1⍴0)⊃2 2⍴0    !!! RANK ERROR
⍝ (⊂2 2⍴0)⊃1 2      !!! RANK ERROR
⍝ (⊂2 2)⊃1 2        !!! RANK ERROR
⍝ (⊂0 2)⊃2 2⍴'ABCD' !!! INDEX ERROR

⍪←{(≢⍵)(×/1↓⍴⍵)⍴⍵; ⍺,[0]⍵}
⍝ ⍪2 3 4 <=> 3 1⍴2 3 4
⍝ ⍪0 <=> 1 1⍴0
⍝ ⍪2 2⍴2 3 4 5 <=> 2 2⍴2 3 4 5
⍝ ⍴⍪2 3⍴⍳6 <=> 2 3
⍝ ⍴⍪2 3 4⍴⍳24 <=> 2 12
⍝ (2 3⍴⍳6)⍪9 <=> 3 3⍴(0 1 2 3 4 5 9 9 9)
⍝ 1⍪2 <=> 1 2

⊢←{⍵}
⍝ 123⊢456 <=> 456
⍝ ⊢456 <=> 456

⊣←{;⍺}
⍝ 123⊣456 <=> 123
⍝ ⊣456 <=> ⍬

≢←{⍬⍴(⍴⍵),1; ~⍺≡⍵}
⍝ ≢0 <=> 1
⍝ ≢0 0 0 <=> 3
⍝ ≢⍬ <=> 0
⍝ ≢2 3⍴⍳6 <=> 2
⍝ 3≢3 <=> 0

⌹←{
  norm←{(⍵+.×+⍵)*0.5}

  QR←{ ⍝ QR decomposition
    n←(⍴⍵)[1]
    1≥n:{t←norm,⍵ ⋄ (⍵÷t)(⍪t)}⍵
    m←⌈n÷2
    a0←((1↑⍴⍵),m)↑⍵
    a1←(0,m)↓⍵
    (q0 r0)←∇a0
    c←(+⍉q0)+.×a1
    (q1 r1)←∇a1-q0+.×c
    (q0,q1)((r0,c)⍪((⌊n÷2),-n)↑r1)
  }

  Rinv←{ ⍝ Inverse of an upper triangular matrix
    1=n←1↑⍴⍵:÷⍵
    m←⌈n÷2
    ai←∇(m,m)↑⍵
    di←∇(m,m)↓⍵
    b←(m,m-n)↑⍵
    bx←-ai+.×b+.×di
    (ai,bx)⍪((⌊n÷2),-n)↑di
  }

  0=⍴⍴⍵:÷⍵
  1=⍴⍴⍵:,∇⍪⍵
  2≠⍴⍴⍵:↗'ASSERTION ERROR'
  0∊≥/⍴⍵:↗'ASSERTION ERROR'
  (Q R)←QR ⍵
  (Rinv R)+.×+⍉Q
  ;
  (⌹⍵)+.×⍺
}
⍝ ⌹2 <=> .5
⍝ ⌹2 2⍴4 3 3 2 <=> 2 2⍴¯2 3 3 ¯4
⍝ (4 4⍴12 1 4 10 ¯6 ¯5 4 7 ¯4 9 3 4 ¯2 ¯6 7 7)⌹93 81 93.5 120.5 <=>
⍝ ... .0003898888816687221 ¯.005029566573526544 .04730651764247189 .0705568912859835

⍨←{⍵⍶⍵;⍵⍶⍺}
⍝ 17-⍨23 <=> 6
⍝ 7⍴⍨2 3 <=> 2 3⍴7
⍝ +⍨2    <=> 4
⍝ -⍨123  <=> 0
