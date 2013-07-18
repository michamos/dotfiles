" {w} -> [é]
" ——————————
" on remappe w sur é :
noremap é w
noremap É W
" corollaire, pour effacer/remplacer un mot quand on n’est pas au début (daé / laé).
" (attention, cela diminue la réactivité du {a}…)
" on utilise onoremap (operator-pending-mode) pour ne pas avoir ce problème avec {a}
onoremap aé aw
onoremap aÉ aW
onoremap ié iw
onoremap iÉ iW
" on veut le même effet en mode visuel
xnoremap aé aw
xnoremap aÉ aW
xnoremap ié iw
xnoremap iÉ iW

" Pour faciliter les manipulations de fenêtres, on utilise {W} comme un Ctrl+W :
noremap w <C-w>
noremap W <C-w><C-w>
 
" [HJKL] -> {CTSR}
" ————————————————
" {cr} = « gauche / droite »
noremap c h
noremap r l
" {ts} = « haut / bas »
noremap t j
noremap s k
" {CR} = « haut / bas de l'écran »
noremap C H
noremap R L
" {TS} = « joindre / aide »
noremap T J
noremap S K
" Corollaire : repli suivant / précédent
noremap zs zk
noremap zt zj
 
" {HJKL} <- [CTSR]
" ————————————————
" {J} = « Jusqu'à »            (j = suivant, J = précédant)
noremap j t
noremap J T
" {L} = « Change »             (l = attend un mvt, L = jusqu'à la fin de ligne)
noremap l c
noremap L C
" {H} = « Remplace »           (h = un caractère slt, H = reste en « Remplace »)
noremap h r
noremap H R
" {K} = « Substitue »          (k = caractère, K = ligne)
noremap k s
noremap K S
" Corollaire : correction orthographique
noremap ]k ]s
noremap [k [s
 
" Désambiguation de {g}
" —————————————————————
" ligne écran précédente / suivante (à l'intérieur d'une phrase)
noremap gs gk
noremap gt gj
" onglet précédant / suivant
noremap gb gT
noremap gé gt
" {gt} / {gT} libre pour agir sur les tags
noremap gt <C-]>
noremap gT <C-T>
" optionnel : {gB} / {gÉ} pour aller au premier / dernier onglet
noremap gB :exe "silent! tabfirst"<CR>
noremap gÉ :exe "silent! tablast"<CR>
" optionnel : {g"} pour aller au début de la ligne écran
noremap g" g0
 
" <> en direct
" ————————————
noremap « <
noremap » >

" Permutation , et ;
" __________________
noremap , ;
noremap ; ,
