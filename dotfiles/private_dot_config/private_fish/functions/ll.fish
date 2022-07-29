function ll --wraps=ls --wraps=exa\ --long\ --all\ --classify\ --icons\ --git\ --ignore-glob=\'.git\' --description alias\ ll\ exa\ --long\ --all\ --classify\ --icons\ --git\ --ignore-glob=\'.git\'
  exa --long --all --classify --icons --git --ignore-glob='.git' $argv;
end
