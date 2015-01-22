<#if header??>
${header}
</#if>
package ${config.providerJavaPackage}.base;

import android.content.ContentResolver;
import android.content.ContentValues;
import android.content.Context;
import android.net.Uri;
import android.provider.BaseColumns;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;

import org.gawst.asyncdb.source.typed.TypedContentProviderDataSource;

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
        ContentValues values = serializer.getContentValuesFromData(model, false);
        if (values.containsKey(BaseColumns._ID)) throw new IllegalStateException("you can't write the _id, values:"+values);
        return insert(values);
    }

    public boolean update(MODEL model) {
        ContentValues values = serializer.getContentValuesFromData(model, true);
        if (values.containsKey(BaseColumns._ID)) throw new IllegalStateException("you can't write the _id, values:"+values);
        return update(model, values);
    }

    public CURSOR query(@Nullable String[] columns, @NonNull SELECTION selection, @Nullable String groupBy, @Nullable String having, @Nullable String orderBy, @Nullable String limit) {
        return query(columns, selection.sel(), selection.args(), groupBy, having, orderBy, limit);
    }

    public DatabaseSerializer<MODEL, CURSOR> getDatabaseSerializer() {
        return serializer;
    }
}