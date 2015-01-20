<#if header??>
${header}
</#if>
package ${config.providerJavaPackage}.base;

import android.content.ContentResolver;
import android.content.Context;
import android.net.Uri;
import android.support.annotation.NonNull;

import org.gawst.asyncdb.source.typed.TypedContentProviderDataSource;
import org.gawst.asyncdb.source.typed.TypedDatabaseElementHandler;

public abstract class AbstractDataSource<MODEL extends BaseModel, CURSOR extends AbstractCursor> extends TypedContentProviderDataSource<MODEL, CURSOR> {
    private final DatabaseSerializer<MODEL, CURSOR> serializer;

    public AbstractDataSource(@NonNull ContentResolver contentResolver, @NonNull Uri contentProviderUri, @NonNull TypedDatabaseElementHandler<MODEL, CURSOR> databaseElementHandler, DatabaseSerializer<MODEL, CURSOR> serializer) {
        super(contentResolver, contentProviderUri, databaseElementHandler);
        this.serializer = serializer;
    }

    public AbstractDataSource(@NonNull Context context, @NonNull Uri contentProviderUri, @NonNull TypedDatabaseElementHandler<MODEL, CURSOR> databaseElementHandler, DatabaseSerializer<MODEL, CURSOR> serializer) {
        super(context, contentProviderUri, databaseElementHandler);
        this.serializer = serializer;
    }

    public Uri insert(MODEL model) {
        return insert(serializer.getContentValuesFromData(model));
    }

    public DatabaseSerializer<MODEL, CURSOR> getDatabaseSerializer() {
        return serializer;
    }
}