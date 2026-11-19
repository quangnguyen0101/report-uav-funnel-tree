def clip_off_funnels(measA: tuple[float, float],
                     measB: tuple[float, float]) -> list[tuple[str, str]]:
    l, a = measA
    l1, a1 = measB

    if l < l1:
        if a > a1:
            return [("B", "right")]
        if a < a1:
            return [("B", "left")]
    elif l1 < l:
        if a > a1:
            return [("A", "left")]
        if a < a1:
            return [("A", "right")]
    else:
        if a > a1:
            return [("A", "left"), ("B", "right")]
        if a < a1:
            return [("A", "right"), ("B", "left")]
    return []