<#if header??>
${header}
</#if>
package ${config.providerJavaPackage}.${entity.packageName};

import android.content.ContentResolver;
import android.content.Context;
import android.database.Cursor;
import android.support.annotation.NonNull;

import ${config.providerJavaPackage}.base.AbstractContentProviderDataSource;
import ${config.providerJavaPackage}.base.DatabaseModelHandler;
import ${config.providerJavaPackage}.base.DatabaseSerializer;

/**
<#if entity.documentation??>
 * ${entity.documentation}
<#else>
 * Content Provider data source for the {@code ${entity.nameLowerCase}} table.
</#if>
 * <p>A data source to be used with {@link org.gawst.asyncdb.AsynchronousDbHelper AsynchronousDbHelper}.</p>
 * @see ${entity.nameCamelCase}DatabaseSerializer
 */
public class ${entity.nameCamelCase}ContentProviderDataSource extends AbstractContentProviderDataSource<${entity.nameCamelCase}Model, ${entity.nameCamelCase}Cursor, ${entity.nameCamelCase}Selection> {
    /**
     * Contructor.
     * <p>Uses a {@link ${config.providerJavaPackage}.${entity.packageName}.${entity.nameCamelCase}DatabaseModelHandler} to read/write data in the Content Provider.</p>
     *
     * @param contentResolver ContentResolver used to access the {@link android.content.ContentProvider ContentProvider}
     */
    public ${entity.nameCamelCase}ContentProviderDataSource(@NonNull ContentResolver contentResolver) {
        this(contentResolver, ${entity.nameCamelCase}DatabaseSerializer.INSTANCE);
    }

    /**
     * Contructor.
     * <p>Uses a {@link ${config.providerJavaPackage}.${entity.packageName}.${entity.nameCamelCase}DatabaseModelHandler} to read/write data in the Content Provider.</p>
     *
     * @param context    Context used to get the {@link android.content.ContentResolver ContentResolver} used to access the {@link android.content.ContentProvider ContentProvider}
     */
    public ${entity.nameCamelCase}ContentProviderDataSource(@NonNull Context context) {
        this(context, ${entity.nameCamelCase}DatabaseSerializer.INSTANCE);
    }

    /**
     * Contructor.
     * <p>Uses a {@link ${config.providerJavaPackage}.${entity.packageName}.${entity.nameCamelCase}DatabaseModelHandler} to read/write data in the Content Provider.</p>
     *
     * @param contentResolver ContentResolver used to access the {@link android.content.ContentProvider ContentProvider}
     * @param serializer      the serializer that will transform a {@link ${entity.nameCamelCase}Cursor} to a {@link ${entity.nameCamelCase}Model}
     *                        or a {@link ${entity.nameCamelCase}Model} into {@code ContentValues}
     */
    public ${entity.nameCamelCase}ContentProviderDataSource(@NonNull ContentResolver contentResolver, @NonNull DatabaseSerializer<${entity.nameCamelCase}Model, ${entity.nameCamelCase}Cursor> serializer) {
        this(contentResolver, new ${entity.nameCamelCase}DatabaseModelHandler(serializer));
    }

    /**
     * Contructor.
     * <p>Uses a {@link ${config.providerJavaPackage}.${entity.packageName}.${entity.nameCamelCase}DatabaseModelHandler} to read/write data in the Content Provider.</p>
     *
     * @param context    Context used to get the {@link android.content.ContentResolver ContentResolver} used to access the {@link android.content.ContentProvider ContentProvider}
     * @param serializer the serializer that will transform a {@link ${entity.nameCamelCase}Cursor} to a {@link ${entity.nameCamelCase}Model}
     *                   or a {@link ${entity.nameCamelCase}Model} into {@code ContentValues}
     */
    public ${entity.nameCamelCase}ContentProviderDataSource(@NonNull Context context, @NonNull DatabaseSerializer<${entity.nameCamelCase}Model, ${entity.nameCamelCase}Cursor> serializer) {
        this(context, new ${entity.nameCamelCase}DatabaseModelHandler(serializer));
    }

    /**
     * Contructor.
     *
     * @param contentResolver ContentResolver used to access the {@link android.content.ContentProvider ContentProvider}.
     * @param modelHandler to handle {@link ${entity.nameCamelCase}Model} read/write/query in the Content Provider.
     */
    public ${entity.nameCamelCase}ContentProviderDataSource(@NonNull ContentResolver contentResolver, @NonNull DatabaseModelHandler<${entity.nameCamelCase}Model, ${entity.nameCamelCase}Cursor, ${entity.nameCamelCase}Selection> modelHandler) {
        super(contentResolver, ${entity.nameCamelCase}Columns.CONTENT_URI, modelHandler);
    }

    /**
     * Contructor.
     *
     * @param context      Context used to get the {@link android.content.ContentResolver ContentResolver} used to access the {@link android.content.ContentProvider ContentProvider}
     * @param modelHandler to handle {@link ${entity.nameCamelCase}Model} read/write/query in the Content Provider.
     */
    public ${entity.nameCamelCase}ContentProviderDataSource(@NonNull Context context, @NonNull DatabaseModelHandler<${entity.nameCamelCase}Model, ${entity.nameCamelCase}Cursor, ${entity.nameCamelCase}Selection> modelHandler) {
        super(context, ${entity.nameCamelCase}Columns.CONTENT_URI, modelHandler);
    }

    @Override
    public ${entity.nameCamelCase}Cursor wrapCursor(Cursor cursor) {
        return new ${entity.nameCamelCase}Cursor(cursor);
    }
}