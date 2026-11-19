def _expand(mesh: Mesh, f: Funnel, out: list[Funnel], tree: Tree,
            clip: ClipFn | None, level_index: int) -> None:
    if f.deleted:
        return

    while True:
        face = mesh.other_face(f.x, f.q, f.S[-1])
        if face is None or face in f.S:
            return

        f.S = f.S + [face]
        v = mesh.third_vertex(face, f.x, f.q)

        f.pqv += mesh.angle(f.x, f.q, v)
        vq = mesh.dist(v, f.q)
        pv = _law_cos_side(f.pq, vq, f.pqv)
        vpq = _angle_sss(vq, pv, f.pq)
        if f.pqv > PI:
            vpq = -vpq
        beta_v = f.spq + vpq

        if beta_v >= PI:
            if f.sp + pv < tree.best[v]:
                tree.best[v] = f.sp + pv
            f.x = v
            continue

        sv = _law_cos_side(f.sp, pv, beta_v)
        psv = _angle_sss(pv, f.sp, sv)

        if sv < tree.best[v]:
            tree.best[v] = sv

        f.pqv = mesh.angle(f.x, v, f.q) + vpq + f.pqv - PI

        if psv >= f.psw:
            f.q, f.pq, f.spq, f.psw = v, pv, beta_v, psv
            continue

        vsw = f.psw - psv
        pvs = _angle_sss(f.sp, pv, sv)
        svq = _angle_sss(f.pq, vq, pv) - pvs

        f.clip_l, f.clip_angle = sv, pvs

        child_left = Funnel(p=f.p, q=v, x=f.x, S=f.S, cusp=f.cusp,
                            sp=f.sp, pq=pv, spq=beta_v, psw=psv,
                            pqv=f.pqv, level=level_index, parent=f)
        child_right = Funnel(p=v, q=f.q, x=v, S=f.S, cusp=f.cusp,
                             sp=sv, pq=vq, spq=svq, psw=vsw,
                             pqv=0.0, level=level_index, parent=f)

        key = (f.p, f.q, v)
        deleted: set[str] = set()
        other: Funnel | None = tree.occupied.get(key)
        if other is not None:
            if clip is None:
                deleted = _default_clip(mesh, f, other, f.p, f.q, v)
                if f.clip_l < other.clip_l:
                    tree.occupied[key] = f
            else:
                deleted = set(clip(mesh, f, other, f.p, f.q, v))
        tree.occupied.setdefault(key, f)

        f.children = [child_left, child_right]
        if "A-left" in deleted:
            child_left.deleted = True
        if "A-right" in deleted:
            child_right.deleted = True

        if other is not None and other is not f and other.children:
            for side, c in (("left", other.children[0]), ("right", other.children[1])):
                if "B-" + side in deleted:
                    c.deleted = True
                    if c in out:
                        out.remove(c)

        if not child_left.deleted:
            out.append(child_left)
        if not child_right.deleted:
            out.append(child_right)
        return