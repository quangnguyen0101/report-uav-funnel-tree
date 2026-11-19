def funnel_tree(mesh: Mesh, s: int, clip: ClipFn | None = None) -> Tree:
    tree = Tree()
    tree.best = [math.inf] * len(mesh.points)
    tree.best[s] = 0.0

    fan = _fan(mesh, s)
    roots = [_make_funnel(mesh, s, fp, fq, face, x=fp) for face, fp, fq in fan]

    for root in roots:
        dq = mesh.dist(s, root.q)
        if dq < tree.best[root.q]:
            tree.best[root.q] = dq

    tree.levels.append(roots)

    level_index = 1
    while tree.levels[-1]:
        nxt: list[Funnel] = []
        for f in tree.levels[-1]:
            _expand(mesh, f, nxt, tree, clip, level_index)
        tree.levels.append(nxt)
        level_index += 1

    if tree.levels and not tree.levels[-1]:
        tree.levels.pop()
    return tree