<#if header??>
${header}
</#if>
package ${config.providerJavaPackage}.base;

import android.content.ContentResolver;
import android.content.Context;
import android.net.Uri;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;

import org.gawst.asyncdb.source.typed.TypedContentProviderDataSource;
import org.gawst.asyncdb.source.typed.TypedDatabaseElementHandler;

public abstract class AbstractDataSource<MODEL extends BaseModel, CURSOR extends AbstractCursor, SELECTION extends AbstractSelection<SELECTION>> extends TypedContentProviderDataSource<MODEL, CURSOR> {
    private final DatabaseSerializer<MODEL, CURSOR> serializer;

    public AbstractDataSource(@NonNull ContentResolver contentResolver, @NonNull Uri contentProviderUri, @NonNull AbstractElementHandler<MODEL, CURSOR, SELECTION> databaseElementHandler, DatabaseSerializer<MODEL, CURSOR> serializer) {
        super(contentResolver, contentProviderUri, databaseElementHandler);
        this.serializer = serializer;
    }

    public AbstractDataSource(@NonNull Context context, @NonNull Uri contentProviderUri, @NonNull AbstractElementHandler<MODEL, CURSOR, SELECTION> databaseElementHandler, DatabaseSerializer<MODEL, CURSOR> serializer) {
        super(context, contentProviderUri, databaseElementHandler);
        this.serializer = serializer;
    }

    public Uri insert(MODEL model) {
        return insert(serializer.getContentValuesFromData(model));
    }

    public CURSOR query(@Nullable String[] columns, @NonNull SELECTION selection, @Nullable String groupBy, @Nullable String having, @Nullable String orderBy, @Nullable String limit) {
        return query(columns, selection.sel(), selection.args(), groupBy, having, orderBy, limit);
    }

    public DatabaseSerializer<MODEL, CURSOR> getDatabaseSerializer() {
        return serializer;
    }
}