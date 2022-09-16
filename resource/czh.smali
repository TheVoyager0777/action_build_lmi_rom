.class public Lmiui/czh;
.super Ljava/lang/Object;


# static fields
.field public static final FALSE:Z = false

.field public static final TRUE:Z = true


# direct methods
.method public static Disable()Z
    .registers 2

    const/4 v0, 0x0

    return v0
.end method

.method public static Disable(Ljava/lang/String;)Z
    .registers 3

    const/4 p0, 0x0

    return p0
.end method

.method public static Disable(Ljava/util/Collection;)Z
    .registers 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<E:",
            "Ljava/lang/Object;",
            ">(",
            "Ljava/util/Collection<",
            "TE;>;)Z"
        }
    .end annotation

    const/4 p0, 0x0

    return p0
.end method

.method public static Enable()Z
    .registers 2

    const/4 v0, 0x1

    return v0
.end method

.method public static Enable(Ljava/util/Collection;)Z
    .registers 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<E:",
            "Ljava/lang/Object;",
            ">(",
            "Ljava/util/Collection<",
            "TE;>;)Z"
        }
    .end annotation

    const/4 p0, 0x1

    return p0
.end method

